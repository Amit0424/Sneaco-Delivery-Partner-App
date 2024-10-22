import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/color.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import 'dash_lines.dart';

class CustomStepperWithImages extends StatelessWidget {
  const CustomStepperWithImages(
      {super.key,
      required this.index,
      required this.imageUrl,
      required this.title});

  final int index;
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: CSizes.lg),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.circle_outlined,
                size: 40,
                color: CColors.darkGrey,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(title,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .apply(fontWeightDelta: 2)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 DashLines(count: 12,),

                Expanded(
                  child: SizedBox(
                    height: HelperFunctions.screenHeight(context) * 0.2,
                      child: CachedNetworkImage(imageUrl: imageUrl)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
