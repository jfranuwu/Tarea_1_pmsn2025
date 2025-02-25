// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';  // Nueva importación
import 'themes/app_themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);  // Agregar const aquí

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aspen',
      theme: AppThemes.lightTheme,
      home: SplashScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}