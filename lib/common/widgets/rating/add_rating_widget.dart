import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/color.dart';
import '../../../utils/constants/sizes.dart';

class AddReviewWidget extends StatelessWidget {
  const AddReviewWidget({
    super.key,
    required this.rating,
    this.onTap,
  });

  final int rating;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: CSizes.spaceBtwSections),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "$rating",
                style: Theme.of(context).textTheme.headlineMedium),
            TextSpan(
                text: " out of 5",
                style: Theme.of(context).textTheme.titleSmall)
          ])),
          const SizedBox(
            height: CSizes.sm,
          ),
          Row(
            children: [
              RatingBar(
                  filledIcon: Icons.star,
                  size: 25,
                  emptyIcon: Icons.star_border,
                  onRatingChanged: (rating) {}),
              const SizedBox(
                width: CSizes.sm,
              ),
              Text("5 (80 k Ratings)",
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .apply(color: CColors.darkGrey))
            ],
          ),
          const SizedBox(
            height: CSizes.md,
          ),
          OutlinedButton(
            onPressed: onTap,
            style: OutlinedButton.styleFrom(
                side: const BorderSide(color: CColors.buttonPrimary),
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 2)),
            child: const Text("Add"),
          )
        ],
      ),
    );
  }
}
