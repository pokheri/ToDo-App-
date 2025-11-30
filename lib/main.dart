import 'package:flutter/material.dart';
import 'package:todo/repository/auth_repository.dart';
import 'package:todo/routes/app_route.dart';
import 'package:todo/routes/routes_name.dart';
import 'package:todo/screens/home_page.dart';
import 'package:todo/screens/welcome_page.dart';
import 'package:todo/services/logout_handler.dart';
import 'package:todo/utils/theme.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  LogoutHandler.onLogout = () {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      Routes.login, // Your login route name
      (route) => false,
    );
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: MyCustomTheme.textLabeldColor,
          brightness: Brightness.light,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 108, 99, 255),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(iconColor: Colors.black, foregroundColor: Colors.black),
        ),
      ),

      /// giving the initial route for the app
      home: AuthState(),
      routes:
          AppRoutes.getRoutes(), // giving all routes informatino to the material app so that it can send the build context accordingly
    );
  }
}

class AuthState extends StatelessWidget {
  const AuthState({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthApi.initAuth(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final isLoggedIn = snapshot.data ?? false;

        return isLoggedIn ? HomePage() : WelcomePage();
      },
    );
  }
}
