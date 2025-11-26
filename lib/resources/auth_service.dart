import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> authenticateUser(
  String email,
  String password,
  BuildContext context,
) async {
  final url = Uri.parse('http://127.0.0.1:8000/auth/login/');

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': email, 'password': password}),
  );

  if (response.statusCode == 200) {
  } else {
    var body = jsonDecode(response.body);
    final message = body['message'] ?? "hello";
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(fontSize: 20)),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
  return {};
}
