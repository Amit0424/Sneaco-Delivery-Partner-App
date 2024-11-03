import 'package:flutter/material.dart';

import '../../constants/color.dart';

class CustomTextTheme {
  CustomTextTheme._();

  // Customized Light Text Theme
  static TextTheme lightTextTheme = const TextTheme(
      headlineLarge: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
          color: CColors.textPrimary),
      headlineMedium: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w600,
          color: CColors.textPrimary),
      headlineSmall: TextStyle(
          fontSize: 18.0,
          // fontWeight: FontWeight.w400,
          color: CColors.textPrimary),
      titleLarge: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: CColors.textPrimary),
      titleMedium: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: CColors.textPrimary),
      titleSmall: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          color: CColors.textPrimary),
      bodyLarge: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: CColors.textPrimary),
      bodyMedium: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.normal,
          color: CColors.textPrimary),
      bodySmall: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: CColors.textPrimary),
      labelLarge: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.normal,
          color: CColors.textPrimary),
      labelMedium: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.normal,
          color: CColors.textPrimary),
      labelSmall: TextStyle(
          fontSize: 12.0, fontWeight: FontWeight.w400, color: Colors.black));

  // Customized Dark Text Theme
  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
        fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white),
    headlineMedium: const TextStyle().copyWith(
        fontSize: 24.0, fontWeight: FontWeight.w600, color: Colors.white),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white),
    titleLarge: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white),
    titleMedium: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white),
    titleSmall: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.white),
    bodyLarge: const TextStyle().copyWith(
        fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.white),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.white),
    bodySmall: const TextStyle().copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: Colors.white.withOpacity(0.5)),
    labelLarge: const TextStyle().copyWith(
        fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.white),
    labelMedium: const TextStyle().copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: Colors.white.withOpacity(0.5)),
  );
}
