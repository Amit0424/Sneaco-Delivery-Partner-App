import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/theme/custom_themes/text_theme.dart';

class Header extends StatelessWidget {
  const Header(
      {super.key,
      required this.logo,
      required this.title,
      required this.screenHeight,
      required this.screenWidth});

  final String logo;
  final String title;
  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * 0.15,
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.02,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SvgPicture.asset(
            logo,
            width: screenWidth * 0.04,
            height: screenHeight * 0.04,
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: CustomTextTheme.lightTextTheme.headlineMedium
                ?.copyWith(color: const Color(0xFF2B2E35)),
          )
        ],
      ),
    );
  }
}
