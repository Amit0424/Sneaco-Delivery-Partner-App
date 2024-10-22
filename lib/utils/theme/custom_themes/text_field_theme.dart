import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../constants/color.dart';

class CustomTextFieldTheme {
  CustomTextFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme =
      const InputDecorationTheme(
          prefixIconColor: Colors.grey,
          suffixIconColor: Colors.grey,
          prefixStyle: TextStyle(color: Colors.grey),
          labelStyle: TextStyle(
              fontSize: 15, color: CColors.accent, fontWeight: FontWeight.w600),
          errorBorder: InputBorder.none,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.transparent, width: 2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.transparent, width: 2)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.transparent, width: 2)),
          focusedErrorBorder: InputBorder.none);

  static InputDecorationTheme darkInputDecorationTheme =
      const InputDecorationTheme(
          prefixIconColor: Colors.grey,
          suffixIconColor: Colors.grey,
          prefixStyle: TextStyle(color: Colors.grey),
          labelStyle:
              TextStyle(
                  fontSize: 15,
                  color: CColors.accent,
                  fontWeight: FontWeight.w600),
          errorBorder: InputBorder.none,
          border:
              OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.transparent, width: 2)),
          focusedBorder:
              OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.transparent, width: 2)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.transparent, width: 2)),
          focusedErrorBorder: InputBorder.none);
}
