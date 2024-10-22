
import 'package:flutter/material.dart';

import '../constants/color.dart';
import 'custom_themes/appbar_theme.dart';
import 'custom_themes/bottom_sheet_theme.dart';
import 'custom_themes/checkbox_theme.dart';
import 'custom_themes/chip_theme.dart';
import 'custom_themes/elevated_button_theme.dart';
import 'custom_themes/outlined_button_theme.dart';
import 'custom_themes/text_field_theme.dart';
import 'custom_themes/text_theme.dart';
import 'custom_themes/textselection_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      useMaterial3: true,
      fontFamily: 'Outfit',
      brightness: Brightness.light,
      primaryColor: CColors.primary,
      scaffoldBackgroundColor: Colors.white,
      textTheme: CustomTextTheme.lightTextTheme,
      textSelectionTheme: CustomTextSelectionTheme.lightTextSelectionTheme,
      elevatedButtonTheme: CustomElevatedTheme.lightElevatedButtonTheme,
      appBarTheme: CustomAppbarTheme.lightAppBarTheme,
      bottomSheetTheme: CustomBottomSheetTheme.lightBottomSheetTheme,
      checkboxTheme: CustomCheckBoxTheme.lightCheckboxTheme,
      chipTheme: CustomChipTheme.lightChipThemeData,
      outlinedButtonTheme: CustomOutlinedButtonTheme.lightOutlinedButtonTheme,
      inputDecorationTheme: CustomTextFieldTheme.lightInputDecorationTheme);

  static ThemeData darkTheme = ThemeData(
      // colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      colorScheme: const ColorScheme.dark(),
      useMaterial3: true,
      fontFamily: 'Outfit',
      brightness: Brightness.dark,
      primaryColor: CColors.primary,
      scaffoldBackgroundColor: Colors.black,
      textTheme: CustomTextTheme.darkTextTheme,
      textSelectionTheme: CustomTextSelectionTheme.darkTextSelectionTheme,
      elevatedButtonTheme: CustomElevatedTheme.darkElevatedButtonTheme,
      appBarTheme: CustomAppbarTheme.darkAppBarTheme,
      bottomSheetTheme: CustomBottomSheetTheme.darkBottomSheetTheme,
      checkboxTheme: CustomCheckBoxTheme.darkCheckboxTheme,
      chipTheme: CustomChipTheme.darkChipThemeData,
      outlinedButtonTheme: CustomOutlinedButtonTheme.darkOutlinedButtonTheme,
      inputDecorationTheme: CustomTextFieldTheme.darkInputDecorationTheme);
}
