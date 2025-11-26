import 'package:flutter/material.dart';
import 'package:todo/routes/app_route.dart';
import 'package:todo/routes/routes_name.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
