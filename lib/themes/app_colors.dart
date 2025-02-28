// lib/utils/app_colors.dart
import 'dart:ui'; // Importación necesaria para la clase Color

// Colores principales de la aplicación
class AppColors {
  // Colores base
  static const Color primary = Color(0xFF4A90E2);
  //static const Color icons=Color(176FF2);
  static const Color secondary = Color(0xFF7ED321);
  static const Color accent = Color(0xFFE91E63);

  // Colores de fondo
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF5F5F5);

  // Colores de texto
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textDisabled = Color(0xFF999999);

  // Colores de estados
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE57373);
  static const Color warning = Color(0xFFFF9800);

  // Colores de gradiente
  static const List<Color> gradientColors = [
    Color(0xFF4A90E2),
    Color(0xFF6C8EE0),
  ];

  // Constructor privado para evitar instanciación
  AppColors._();
}