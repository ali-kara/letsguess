import 'package:flutter/material.dart';

const Color correctColor = Color(0xFF538D4E);
const Color inWordColor = Color(0xFFB49F3A);
const Color notInWordColor = Color(0xFF3A3A3C);

class AppColors {
  AppColors._();

  // Vibrant Game Colors
  static const Color primary = Color(0xFF6366F1); // Indigo
  static const Color secondary = Color(0xFFF59E0B); // Amber
  static const Color accent = Color(0xFF10B981); // Emerald
  static const Color purple = Color(0xFF8B5CF6); // Violet
  static const Color pink = Color(0xFFEC4899); // Pink
  static const Color orange = Color(0xFFF97316); // Orange
  static const Color cyan = Color(0xFF06B6D4); // Cyan

  // Background Colors
  static const Color darkBackground = Color(0xFF0F172A); // Slate 900
  static const Color darkSurface = Color(0xFF1E293B); // Slate 800
  static const Color lightBackground = Color(0xFFF8FAFC); // Slate 50
  static const Color lightSurface = Color(0xFFFFFFFF);

  // Game Colors
  static const Color success = Color(0xFF22C55E); // Green 500
  static const Color warning = Color(0xFFF59E0B); // Amber 500
  static const Color error = Color(0xFFEF4444); // Red 500

  // Gradient Colors
  static const List<Color> primaryGradient = [primary, purple];
  static const List<Color> secondaryGradient = [secondary, orange];
  static const List<Color> accentGradient = [accent, cyan];
  static const List<Color> rainbowGradient = [
    primary,
    purple,
    pink,
    orange,
    secondary,
    accent,
    cyan
  ];
}
