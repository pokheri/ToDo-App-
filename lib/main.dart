import 'package:flutter/material.dart';
import 'package:todo/routes/app_route.dart';
import 'package:todo/routes/routes_name.dart';
import 'package:todo/services/logout_handler.dart';

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
          seedColor: Color(0xffABE7B2),
          brightness: Brightness.light,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 108, 99, 255),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
        ),
      ),
      initialRoute: Routes.welcome,

      /// giving the initial route for the app
      routes:
          AppRoutes.getRoutes(), // giving all routes informatino to the material app so that it can send the build context accordingly
    );
  }
}
