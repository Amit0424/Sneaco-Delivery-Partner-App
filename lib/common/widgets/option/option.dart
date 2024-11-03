import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants/color.dart';
import '../../../utils/theme/custom_themes/text_theme.dart';

class Option extends StatelessWidget {
  const Option(
      {super.key,
      required this.onTap,
      required this.title,
      required this.icon});

  final VoidCallback onTap;
  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              colorFilter: const ColorFilter.mode(
                CColors.primary,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              title,
              style: CustomTextTheme.lightTextTheme.titleSmall?.copyWith(
                color:
                    title != "Log Out" ? CColors.textPrimary : CColors.primary,
              ),
            ),
            if (title != "Log Out") const Spacer(),
            if (title != "Log Out")
              const Icon(
                Icons.arrow_forward_ios,
                color: CColors.primary,
              ),
          ],
        ),
      ),
    );
  }
}
