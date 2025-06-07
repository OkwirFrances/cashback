import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF6C5CE7);
  static const Color secondary = Color(0xFF00CEFF);
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color error = Color(0xFFD63031);
  static const Color success = Color(0xFF00B894);
  static const Color warning = Color(0xFFFDCB6E);
  static const Color textPrimary = Color(0xFF2D3436);
  static const Color textSecondary = Color(0xFF636E72);

  // Mobile Money Colors
  static const Color mtnYellow = Color(0xFFFFCC00);
  static const Color airtelRed = Color(0xFFED1C24);

  // Social Colors
  static const Color facebookBlue = Color(0xFF4267B2);
  static const Color googleRed = Color(0xFFDB4437);

  // Gradient
  static LinearGradient primaryGradient = const LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
