import 'package:flutter/material.dart';
import 'colors.dart';

class AppTextStyles {
  // Headlines
  static const TextStyle headline1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle headline2 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle headline3 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle headline4 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // Subtitles
  static const TextStyle subtitle1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle subtitle2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // Body
  static const TextStyle body1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  static const TextStyle body2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  // Buttons
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // Captions
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  // Overrides
  static TextStyle headline4White = headline4.copyWith(color: Colors.white);
  static TextStyle body1White = body1.copyWith(color: Colors.white);
}
