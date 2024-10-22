import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants/color.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/texts.dart';

class DetailsAndAddButton extends StatelessWidget {
  const DetailsAndAddButton({super.key,
    required this.firstRowEnable,
    this.paddingFirstRow = 0,
    this.paddingSecondRow = CSizes.sm,
    this.lastRowEnable = false,
    this.paddingLastRow = CSizes.sm,
    required this.categoryName,
    required this.therapyTitle,
    required this.therapyDescription,
    required this.startPrice});

  final bool firstRowEnable;
  final bool lastRowEnable;
  final double paddingFirstRow;
  final double paddingSecondRow;
  final double paddingLastRow;
  final String? categoryName;
  final String therapyTitle;
  final String therapyDescription;
  final String startPrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        // First Row
        firstRowEnable
            ? Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                // SvgPicture.asset(
                //   CImages.verifiedIcon,
                //   color: CColors.primary,
                // ),
                const SizedBox(
                  width: CSizes.sm,
                ),
                Text(
                  categoryName!,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyLarge!
                      .apply(
                      fontSizeDelta: 1, color: CColors.buttonPrimary),
                ),
              ],
            ),
            // IconButton(
            //     onPressed: null,
            //     icon: SvgPicture.asset(
            //       // CImages.addIcon,
            //       color: CColors.primary,
            //     ))
          ],
        )
            : const SizedBox(),

        // Second Row
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: Text(
              therapyTitle,
              style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge!
                  .apply(fontWeightDelta: 1),
            ),
          ),
        ),

        SizedBox(
          height: paddingFirstRow,
        ),

        // Third Row
        Expanded(
          child:
          SizedBox(width: double.infinity, child: Text(therapyDescription)),
        ),

        SizedBox(
          height: paddingSecondRow,
        ),

        // rating bar
        // Row(
        //   children: [
        //     const RatingBar.readOnly(
        //       initialRating: 4,
        //       maxRating: 5,
        //       filledIcon: Icons.star_rounded,
        //       filledColor: CColors.starColor,
        //       emptyIcon: Icons.star_border_rounded,
        //       emptyColor: CColors.starColor,
        //       size: CSizes.iconMs,
        //       isHalfAllowed: false,
        //     ),
        //     const SizedBox(
        //       width: CSizes.sm,
        //     ),
        //     Text(
        //       "4.9",
        //       style: Theme.of(context)
        //           .textTheme
        //           .bodyLarge!
        //           .apply(fontWeightDelta: 2),
        //     ),
        //     const SizedBox(
        //       width: CSizes.sm,
        //     ),
        //     Container(height: CSizes.md, child: VerticalDivider()),
        //     Text("5 Reviews")
        //   ],
        // ),

        // Last Row

        if (lastRowEnable)
          SizedBox(
            height: paddingLastRow,
          ),
        if (lastRowEnable)
          Row(
            children: [
              Text(
                "Starts at ${CTexts.rupee} $startPrice",
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyLarge!
                    .apply(fontWeightDelta: 1),
              ),
            ],
          )
      ],
    );
  }
}
