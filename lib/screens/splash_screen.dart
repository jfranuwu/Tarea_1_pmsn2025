// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../utils/app_fonts.dart';
import '../themes/app_themes.dart';
import './explore.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Aspen',
          style: AppFonts.aspenTitleStyle(24),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/wallpaper.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Título centrado arriba
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(
                  'Aspen',
                  style: AppFonts.aspenTitleStyle(80.0),
                  textAlign: TextAlign.center,
                ),
              ),
              
              // Espacio flexible
              Expanded(
                child: Container(),
              ),
              
              // Subtítulo y botón
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Plan your',
                      style: AppFonts.subtitleStyle(24.0),
                    ),
                    Text(
                      'Luxurious Vacation',
                      style: AppFonts.subtitleStyle2(48.0),
                    ),
                    const SizedBox(height: 8.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ExploreScreen()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
                        child: Text(
                          'Explore',
                          style: AppFonts.botonInicio(18.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}