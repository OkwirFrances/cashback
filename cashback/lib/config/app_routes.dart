import 'package:flutter/material.dart';
import '../shared/styles/colors.dart';
import '../shared/styles/text_styles.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.deepPurple,
    primaryColor: AppColors.primary,
    secondaryHeaderColor: AppColors.secondary,
    scaffoldBackgroundColor: AppColors.background,
    fontFamily: 'Poppins',

    // AppBar Theme
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.primary,
      titleTextStyle: AppTextStyles.headline6.copyWith(color: Colors.white),
      iconTheme: const IconThemeData(color: Colors.white),
      centerTitle: true,
    ),

    // Text Theme
    textTheme: TextTheme(
      headline1: AppTextStyles.headline1,
      headline2: AppTextStyles.headline2,
      headline3: AppTextStyles.headline3,
      headline4: AppTextStyles.headline4,
      subtitle1: AppTextStyles.subtitle1,
      subtitle2: AppTextStyles.subtitle2,
      bodyText1: AppTextStyles.body1,
      bodyText2: AppTextStyles.body2,
      button: AppTextStyles.button,
      caption: AppTextStyles.caption,
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      labelStyle: AppTextStyles.body2.copyWith(color: AppColors.textSecondary),
    ),

    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: AppColors.primary,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: AppTextStyles.button,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        side: const BorderSide(color: AppColors.primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: AppTextStyles.button.copyWith(color: AppColors.primary),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: AppColors.primary,
        textStyle: AppTextStyles.button.copyWith(color: AppColors.primary),
      ),
    ),

    // Card Theme
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.all(8),
    ),

    // Dialog Theme
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),

    // SnackBar Theme
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );

  static ThemeData darkTheme = lightTheme.copyWith(
    scaffoldBackgroundColor: Colors.grey[900],
    cardColor: Colors.grey[800],
    primaryColor: Colors.deepPurple[300],
    textTheme: TextTheme(
      headline1: AppTextStyles.headline1.copyWith(color: Colors.white),
      headline2: AppTextStyles.headline2.copyWith(color: Colors.white),
      headline3: AppTextStyles.headline3.copyWith(color: Colors.white),
      headline4: AppTextStyles.headline4.copyWith(color: Colors.white),
      subtitle1: AppTextStyles.subtitle1.copyWith(color: Colors.white),
      subtitle2: AppTextStyles.subtitle2.copyWith(color: Colors.white),
      bodyText1: AppTextStyles.body1.copyWith(color: Colors.white),
      bodyText2: AppTextStyles.body2.copyWith(color: Colors.white70),
      button: AppTextStyles.button.copyWith(color: Colors.white),
      caption: AppTextStyles.caption.copyWith(color: Colors.white70),
    ),
    inputDecorationTheme: lightTheme.inputDecorationTheme.copyWith(
      fillColor: Colors.grey[800],
      labelStyle: AppTextStyles.body2.copyWith(color: Colors.white70),
    ),
  );
}
