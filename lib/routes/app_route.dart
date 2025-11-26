import 'package:flutter/material.dart';
import 'package:todo/routes/routes_name.dart';
import 'package:todo/screens/home_page.dart';
import 'package:todo/screens/authentication/login_page.dart';
import 'package:todo/screens/authentication/register_page.dart';
import 'package:todo/screens/authentication/reset_email_page.dart';
import 'package:todo/screens/authentication/reset_password_page.dart';
import 'package:todo/screens/welcome_page.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      Routes.login: (context) => LoginPage(),
      Routes.singup: (context) => RegisterPage(),
      Routes.home: (context) => HomePage(),
      Routes.welcome: (context) => WelcomePage(),
      Routes.resetPassowrd: (context) => ResetPasswordPage(),
      Routes.resetEmail: (context) => ResetEmailPage(),
    };
  }
}
