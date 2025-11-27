import 'package:dio/dio.dart';
import 'package:todo/services/logout_handler.dart';

import 'secure_storage.dart';

class TokenManager {
  static Future<String?> getAccessToken() async {
    return await SecureStorage.getAccessToken();
  }

  static Future<String?> getRefreshToken() async {
    return await SecureStorage.getRefreshToken();
  }

  static Future<void> storeAccessToken(String access) async {
    await SecureStorage.saveAccessToken(access);
  }

  static Future<void> saveTokens(String access, String refresh) async {
    await SecureStorage.saveAccessToken(access);
    await SecureStorage.saveRefreshToken(refresh);
  }

  static Future<void> clear() async {
    await SecureStorage.clearToken();
    LogoutHandler.triggerLogout();
  }

  // Refresh token API call
  static Future<String?> refreshAccessToken(Dio dio) async {
    final refreshToken = await getRefreshToken();
    if (refreshToken == null) return null;

    try {
      final response = await dio.post("/auth/token/refresh/", data: {"refresh": refreshToken});

      final newAccess = response.data["access"];
      if (newAccess != null) {
        await SecureStorage.saveAccessToken(newAccess);
        return newAccess;
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
