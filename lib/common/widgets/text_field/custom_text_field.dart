import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/constants/color.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.inputFormatter,
      required this.onSubmitted,
      this.suffixIcon,
      this.onTapOnSuffixIcon,
      this.onTap,
      required this.readOnly,
      this.maxLength,
      required this.minLength,
      required this.errorText,
      required this.keyboardType});

  final TextEditingController controller;
  final String hintText;
  final TextInputFormatter inputFormatter;
  final void Function() onSubmitted;
  final String? suffixIcon;
  final TextInputType keyboardType;
  final Function()? onTapOnSuffixIcon;
  final bool readOnly;
  final void Function()? onTap;
  final String errorText;
  final int? maxLength;
  final int minLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly,
      controller: controller,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        counter: const Offstage(),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: CColors.textSecondary,
          fontSize: 14,
        ),
        suffixIcon: suffixIcon != null
            ? GestureDetector(
                onTap: onTapOnSuffixIcon ?? () {},
                child: Container(
                  padding: const EdgeInsets.all(14),
                  child: SvgPicture.asset(
                    suffixIcon!,
                    height: 10,
                    width: 10,
                  ),
                ),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: CColors.textSecondary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: CColors.textSecondary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: CColors.dark,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: CColors.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: CColors.error,
          ),
        ),
      ),
      cursorColor: CColors.primary,
      keyboardType: keyboardType,
      inputFormatters: [
        inputFormatter,
      ],
      maxLength: maxLength,
      maxLines: 1,
      onFieldSubmitted: (value) {
        FocusScope.of(context).unfocus();
        onSubmitted();
      },
      onTapOutside: (value) {
        FocusScope.of(context).unfocus();
      },
      validator: (value) {
        if (value!.isEmpty && value.length < minLength) {
          return errorText;
        }
        return null;
      },
    );
  }
}
