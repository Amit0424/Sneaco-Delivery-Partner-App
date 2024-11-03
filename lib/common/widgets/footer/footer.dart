import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants/color.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/theme/custom_themes/text_theme.dart';

class Footer extends StatelessWidget {
  const Footer(
      {super.key,
      required this.screenHeight,
      required this.screenWidth,
      required this.ordersButton,
      required this.accountButton});

  final double screenHeight;
  final double screenWidth;
  final VoidCallback ordersButton;
  final VoidCallback accountButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * 0.13,
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.02,
        horizontal: screenWidth * 0.05,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFD9D9D9),
            blurRadius: 20,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildFooterButton(CColors.primary, Colors.white, CImages.bag,
              "Orders", screenHeight, screenWidth, ordersButton),
          SizedBox(width: screenWidth * 0.05),
          _buildFooterButton(
              Colors.white,
              const Color(0xFF2B2E35),
              CImages.account,
              "Account",
              screenHeight,
              screenWidth,
              accountButton),
        ],
      ),
    );
  }
}

Widget _buildFooterButton(
    Color backgroundColor,
    Color foregroundColor,
    String icon,
    String title,
    double screenHeight,
    double screenWidth,
    VoidCallback onTap) {
  return Expanded(
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize: Size(double.infinity, screenHeight * 0.065),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.02,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SvgPicture.asset(
            icon,
            width: screenWidth * 0.03,
            height: screenHeight * 0.03,
            colorFilter: ColorFilter.mode(
              foregroundColor,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            title,
            style: CustomTextTheme.lightTextTheme.titleLarge?.copyWith(
              color: foregroundColor,
            ),
          ),
        ],
      ),
    ),
  );
}
