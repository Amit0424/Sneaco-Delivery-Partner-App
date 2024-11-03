import 'package:flutter/material.dart';

import '../constants/color.dart';
import 'custom_themes/text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: CColors.primary,
    scaffoldBackgroundColor: Colors.white,
    textTheme: CustomTextTheme.lightTextTheme,
  );

  static ThemeData darkTheme = ThemeData(
    // colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    colorScheme: const ColorScheme.dark(),
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: CColors.primary,
    scaffoldBackgroundColor: Colors.black,
    textTheme: CustomTextTheme.darkTextTheme,
  );
}
