import 'package:flutter/material.dart';

import '../../constants/color.dart';

class CustomElevatedTheme {
  CustomElevatedTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: CColors.buttonPrimary,
          disabledBackgroundColor: Colors.grey,
          disabledForegroundColor: Colors.white,
          side: const BorderSide(color: Colors.transparent),
          padding: const EdgeInsets.symmetric(vertical: 18),
          textStyle: const TextStyle(
              fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))));


  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: CColors.buttonPrimary,
          disabledBackgroundColor: Colors.grey,
          disabledForegroundColor: Colors.white,
          side: const BorderSide(color: Colors.transparent),
          padding: const EdgeInsets.symmetric(vertical: 18),
          textStyle: const TextStyle(
              fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))));
}
