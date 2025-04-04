// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'themes/app_themes.dart';
import 'screens/explore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aspen',
      theme: AppThemes.lightTheme,
      home: SplashScreen(),
      routes: {
          '/explore': (context) => const ExploreScreen(),

      },
    );
  }
}