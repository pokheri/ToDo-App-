import 'package:dio/dio.dart';
import 'package:todo/services/token_manager.dart';

class ApiClient {
  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: "http://localhost:8000/",
        connectTimeout: Duration(seconds: 4),
        receiveTimeout: Duration(seconds: 4),
      ),
    );

    bool isRefreshing = false;

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final access = await TokenManager.getAccessToken();

          if (access != null) {
            options.headers['Authorization'] = "Bearer $access";
            options.headers["Content-Type"] = 'application/json';
          }

          return handler.next(options);
        },

        onResponse: (response, handler) async {
          final path = response.requestOptions.path;
          final data = response.data;

          // Store login tokens
          if (path.contains('auth/login/')) {
            final access = data['access'];
            final refresh = data['refresh'];

            if (access != null && refresh != null) {
              await TokenManager.saveTokens(access, refresh);
            }
          }

          // Store refreshed access token
          if (path.contains('auth/token/refresh/')) {
            final newAccess = data['access'];
            if (newAccess != null) {
              await TokenManager.storeAccessToken(newAccess);
            }
          }

          return handler.next(response);
        },

        // ---------------------------------------------------------
        // Handle 401 errors and refresh token logic
        // ---------------------------------------------------------
        onError: (error, handler) async {
          final status = error.response?.statusCode ?? 0;
          final path = error.requestOptions.path;

          // 1. If refresh endpoint itself fails → do NOT retry
          if (path.contains("auth/token/refresh/")) {
            await TokenManager.clear();
            return handler.next(error);
          }

          // 2. Only handle 401 errors
          if (status != 401) {
            return handler.next(error);
          }

          // 3. Do not refresh for login/signup
          if (path.contains("auth/login/") || path.contains("auth/signup/")) {
            return handler.next(error);
          }

          // 4. Avoid parallel refreshes
          if (isRefreshing) {
            return handler.next(error);
          }

          isRefreshing = true;

          // 5. Attempt refresh ONCE
          final newAccess = await TokenManager.refreshAccessToken(dio);

          isRefreshing = false;

          // 6. If refresh failed → logout + do NOT retry
          if (newAccess == null) {
            await TokenManager.clear();
            return handler.next(error);
          }

          // 7. Refresh succeeded → retry original request once
          final RequestOptions requestOptions = error.requestOptions;

          final Options newOptions = Options(
            method: requestOptions.method,
            headers: {...requestOptions.headers, "Authorization": "Bearer $newAccess"},
          );

          try {
            final newResponse = await dio.request(
              requestOptions.path,
              data: requestOptions.data,
              queryParameters: requestOptions.queryParameters,
              options: newOptions,
            );

            return handler.resolve(newResponse);
          } catch (e) {
            // If retry fails → do NOT attempt refresh again
            return handler.next(error);
          }
        },
      ),
    );

    return dio;
  }
}
