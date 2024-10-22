import 'package:flutter/material.dart';

import '../../../utils/constants/color.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class CustomDialog {
  showCommonDialog({
    required BuildContext context,
    required String title,
    String? subTitle,
    required void Function()? firstButtonTap,
    required String firstButtonName,
    required void Function()? secondButtonTap,
    required String secondButtonName,
  }) {
    final isDark = HelperFunctions.isDarkMode(context);
    showDialog(
        context: context,
        builder: (context) => Dialog(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: isDark ? CColors.dark : CColors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Text(
                          title,
                          style: const TextStyle(
                              fontSize: 20,
                              color: CColors.buttonPrimary,
                              fontWeight: FontWeight.w800),
                        )),
                    const SizedBox(
                      height: CSizes.spaceBtwItems,
                    ),
                    if (subTitle != null)
                      Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Text(
                            subTitle,
                            style: TextStyle(color: Colors.grey),
                          )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: TextButton(
                                      onPressed: firstButtonTap,
                                      child: Text(
                                        firstButtonName,
                                        style: const TextStyle(
                                            color: CColors.buttonPrimary,
                                            fontWeight: FontWeight.bold),
                                      )))),
                          Expanded(
                            child: InkWell(
                              onTap: secondButtonTap,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: CColors.buttonPrimary,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 13),
                                  child: Center(
                                      child: Text(
                                    secondButtonName,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ));
  }
}
