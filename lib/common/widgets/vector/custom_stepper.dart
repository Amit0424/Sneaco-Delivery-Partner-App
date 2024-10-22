import 'package:flutter/material.dart';

import '../../../utils/constants/color.dart';
import '../../../utils/constants/sizes.dart';
import 'dash_lines.dart';

class CustomStepper extends StatelessWidget {
  const CustomStepper({
    super.key, required this.index, required this.description,required this.title
  });

  final int index;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: CSizes.lg),
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
                      .apply(
                      fontWeightDelta:
                      2)),
            ],
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(
                horizontal: 20),
            child: Row(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                const DashLines(),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Text(
                      description,
                      overflow: TextOverflow
                          .visible,
                      maxLines: 2,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}