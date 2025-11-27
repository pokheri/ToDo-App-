import 'package:flutter/material.dart';
import 'package:todo/services/api_client.dart';

void showSnakbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: TextStyle(fontSize: 20)),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.redAccent,
    ),
  );
}

// we created the dio instance to make connection with our backend
final dio = ApiClient.create();

class AuthApi {
  static Future<bool> authenticateUser(String email, String password) async {
    final response = await dio.post('auth/login/', data: {"email": email, "password": password});

    if (response.statusCode == 200) return true;
    return false;
  }

  static Future<bool> logoutUser() async {
    final response = await dio.post('auth/logout/');

    if (response.statusCode == 200) return true;
    return false;
  }

  static Future<bool> createAccount(String email, String password) async {
    final response = await dio.post('auth/signup/', data: {"email": email, "password": password});

    if (response.statusCode == 200) return true;
    return false;
  }

  static Future<bool> deleteAccount(String email, String password) async {
    final response = await dio.post('auth/delete/');

    if (response.statusCode == 200) return true;
    return false;
  }

  static Future<bool> requestOtp(String email) async {
    final response = await dio.post('auth/request-otp/', data: {"email": email});

    if (response.statusCode == 200) return true;
    return false;
  }

  static Future<bool> resetPassword(String email, String password, String otp) async {
    final response = await dio.post(
      'auth/reset/',
      data: {"email": email, "password": password, "otp": otp},
    );

    if (response.statusCode == 200) return true;
    return false;
  }
}
