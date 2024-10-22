import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../common/widgets/texts/section_heading.dart';
import '../../utils/constants/color.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_functions.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final DropdownController _genderFilerDropDownController =
      DropdownController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = HelperFunctions.screenWidth(context);
    final screenHeight = HelperFunctions.screenHeight(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: CSizes.spaceBtwItems),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: CSizes.appBarHeight),
              const DiscountInfoBanner(),

              /// Location and wallet icon
              Row(
                children: [
                  SvgPicture.asset(
                    CImages.locationIcon,
                  ),
                  const Text("Raja Park"),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.keyboard_arrow_down_rounded)),
                  SvgPicture.asset(
                    CImages.walletIcon,
                  ),
                ],
              ),

              /// Search Bar
              Card(
                  color: CColors.white,
                  elevation: 3,
                  shadowColor: CColors.lightGrey,
                  child: TextFormField(
                    decoration: InputDecoration(
                        prefixIconConstraints: BoxConstraints(
                            minWidth: screenWidth * 0.05,
                            minHeight: screenWidth * 0.05),
                        prefixIcon: SvgPicture.asset(
                          CImages.searchIcon,
                          // height: screenWidth * 0.0,
                        ),
                        hintText: "Shop name or service",
                        hintStyle: const TextStyle(color: CColors.darkGrey)),
                  )),

              const SizedBox(
                height: CSizes.spaceBtwItems * 1.5,
              ),

              /// Filter DropDowns
              FilterDropDownsList(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                  genderFilerDropDownController:
                      _genderFilerDropDownController),
              const SizedBox(
                height: CSizes.spaceBtwSections,
              ),

              /// Header
              const SectionHeading(title: "Beauty services"),

              /// Services
              SizedBox(
                height: screenWidth * 0.4,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: screenWidth * 0.26,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CircleAvatar(
                              radius: screenWidth * 0.13,
                              backgroundImage: AssetImage(
                                CImages.hairCutForMenImage,
                              ),
                            ),
                            const Text(
                              "Haircut for men",
                              overflow: TextOverflow.visible,
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: screenWidth * 0.06,
                      );
                    },
                    itemCount: 10),
              ),

              /// Header
              const SectionHeading(title: "Beauty Products"),

              /// Services
              SizedBox(
                height: screenWidth * 0.4,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: screenWidth * 0.26,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CircleAvatar(
                              radius: screenWidth * 0.13,
                              backgroundImage: AssetImage(
                                CImages.hairCutForMenImage,
                              ),
                            ),
                            const Text(
                              "Haircut for men",
                              overflow: TextOverflow.visible,
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: screenWidth * 0.06,
                      );
                    },
                    itemCount: 10),
              ),

              const SizedBox(
                height: CSizes.spaceBtwItems,
              ),

              /// Header
              const SectionHeading(
                title: "Popular near you",
                showActionButton: false,
              ),
              const SizedBox(
                height: CSizes.spaceBtwSections,
              ),

              /// Nearby Shop Details
              SizedBox(
                height: screenWidth * 0.7,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return ShopDetailsWidget(screenWidth: screenWidth);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 35,
                      );
                    },
                    itemCount: 5),
              ),

              /// Header
              const SectionHeading(
                title: "Best Offers",
              ),
              const SizedBox(
                height: CSizes.spaceBtwSections,
              ),

              /// Best Offers
              SizedBox(
                height: screenWidth * 0.7,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return ShopDetailsWidget(
                        screenWidth: screenWidth,
                        isDiscount: true,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 35,
                      );
                    },
                    itemCount: 5),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ShopDetailsWidget extends StatelessWidget {
  const ShopDetailsWidget({
    super.key,
    required this.screenWidth,
    this.isDiscount = false,
  });

  final double screenWidth;
  final bool isDiscount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
            child: Stack(
              children: [
                Image(image: AssetImage(CImages.shopImage)),
                Visibility(
                  visible: isDiscount,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        color: CColors.secondary,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        SvgPicture.asset(CImages.offersColorsIcon),
                        const Text("50% Off")
                      ],
                    ),
                  ),
                )
              ],
            )),
        const SizedBox(
          height: 5,
        ),
        Text(
          "For MEN & WOMEN",
          style: TextStyle(
              fontSize: screenWidth * 0.025,
              color: CColors.darkGrey,
              fontWeight: FontWeight.w600),
        ),
        Text(
          "Style N Scissors",
          style: TextStyle(
              fontSize: screenWidth * 0.045, fontWeight: FontWeight.w600),
        ),
        Row(
          children: [
            const Text(
              "Haircut, Spa, Massage",
              style: TextStyle(
                color: CColors.darkGrey,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Icon(
              Icons.circle,
              size: screenWidth * 0.02,
              color: CColors.grey,
            ),
            const SizedBox(
              width: 5,
            ),
            Row(
              children: [
                SvgPicture.asset(CImages.starIcon),
                const Text(
                  "4.1",
                  style: TextStyle(
                    color: CColors.darkGrey,
                  ),
                )
              ],
            )
          ],
        ),
        Row(
          children: [
            const Text(
              "Vaishali Nagar",
              style: TextStyle(
                color: CColors.darkGrey,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Icon(
              Icons.circle,
              size: screenWidth * 0.02,
              color: CColors.grey,
            ),
            const SizedBox(
              width: 5,
            ),
            const Row(
              children: [
                Text(
                  "5.0",
                  style: TextStyle(
                    color: CColors.darkGrey,
                  ),
                ),
                Text(
                  "Kms",
                  style: TextStyle(
                    color: CColors.darkGrey,
                  ),
                )
              ],
            ),
            const SizedBox(
              width: 5,
            ),
            Icon(
              Icons.circle,
              size: screenWidth * 0.02,
              color: CColors.grey,
            ),
            const SizedBox(
              width: 5,
            ),
            const Text(
              "₹₹",
              style: TextStyle(
                color: CColors.darkGrey,
              ),
            )
          ],
        ),
      ],
    );
  }
}

class FilterDropDownsList extends StatelessWidget {
  const FilterDropDownsList({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required DropdownController genderFilerDropDownController,
  }) : _genderFilerDropDownController = genderFilerDropDownController;

  final double screenHeight;
  final double screenWidth;
  final DropdownController _genderFilerDropDownController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight * 0.05,
      child: ListView(
        scrollDirection: Axis.horizontal,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          // Gender
          SizedBox(
            width: screenWidth * 0.3,
            child: CoolDropdown(
              controller: _genderFilerDropDownController,
              dropdownList: const [],
              onChange: (value) {
                _genderFilerDropDownController.close();
              },
              resultOptions: ResultOptions(
                mainAxisAlignment: MainAxisAlignment.end,
                placeholder: "Gender",
                placeholderTextStyle: TextStyle(
                    fontSize: screenWidth * 0.045, color: CColors.darkGrey),
                boxDecoration: BoxDecoration(
                    // border: Border.all(color: CColors.grey),
                    color: CColors.lightGrey,
                    borderRadius: BorderRadius.circular(screenWidth * 0.2)),
                render: ResultRender.label,
                icon: const SizedBox(
                  width: 10,
                  height: 10,
                  child: CustomPaint(
                    painter: DropdownArrowPainter(color: Color(0xff8787FF)),
                  ),
                ),
              ),
              dropdownOptions: DropdownOptions(
                  align: DropdownAlign.left,
                  borderRadius: BorderRadius.circular(10)),
              dropdownItemOptions: DropdownItemOptions(
                boxDecoration:
                    BoxDecoration(color: CColors.secondary.withOpacity(0.5)),
                selectedTextStyle: TextStyle(
                  color: CColors.white,
                  fontSize: screenWidth * 0.02,
                ),
                selectedBoxDecoration:
                    BoxDecoration(color: CColors.secondary.withOpacity(0.5)),
              ),
            ),
          ),
          const SizedBox(
            width: CSizes.spaceBtwItems,
          ),

          // Price
          SizedBox(
            width: screenWidth * 0.3,
            child: CoolDropdown(
              controller: _genderFilerDropDownController,
              dropdownList: const [],
              onChange: (value) {
                _genderFilerDropDownController.close();
              },
              resultOptions: ResultOptions(
                mainAxisAlignment: MainAxisAlignment.end,
                placeholder: "Price",
                placeholderTextStyle: TextStyle(
                    fontSize: screenWidth * 0.045, color: CColors.darkGrey),
                boxDecoration: BoxDecoration(
                    // border: Border.all(color: CColors.grey),
                    color: CColors.lightGrey,
                    borderRadius: BorderRadius.circular(screenWidth * 0.2)),
                render: ResultRender.label,
                icon: const SizedBox(
                  width: 10,
                  height: 10,
                  child: CustomPaint(
                    painter: DropdownArrowPainter(color: Color(0xff8787FF)),
                  ),
                ),
              ),
              dropdownOptions: DropdownOptions(
                  align: DropdownAlign.left,
                  borderRadius: BorderRadius.circular(10)),
              dropdownItemOptions: DropdownItemOptions(
                boxDecoration:
                    BoxDecoration(color: CColors.secondary.withOpacity(0.5)),
                selectedTextStyle: TextStyle(
                  color: CColors.white,
                  fontSize: screenWidth * 0.02,
                ),
                selectedBoxDecoration:
                    BoxDecoration(color: CColors.secondary.withOpacity(0.5)),
              ),
            ),
          ),
          const SizedBox(
            width: CSizes.spaceBtwItems,
          ),
          // Offers
          SizedBox(
            width: screenWidth * 0.3,
            child: CoolDropdown(
              controller: _genderFilerDropDownController,
              dropdownList: const [],
              onChange: (value) {
                _genderFilerDropDownController.close();
              },
              resultOptions: ResultOptions(
                mainAxisAlignment: MainAxisAlignment.end,
                placeholder: "Offers",
                placeholderTextStyle: TextStyle(
                    fontSize: screenWidth * 0.045, color: CColors.darkGrey),
                boxDecoration: BoxDecoration(
                    // border: Border.all(color: CColors.grey),
                    color: CColors.lightGrey,
                    borderRadius: BorderRadius.circular(screenWidth * 0.2)),
                render: ResultRender.label,
                icon: const SizedBox(
                  width: 10,
                  height: 10,
                  child: CustomPaint(
                    painter: DropdownArrowPainter(color: Color(0xff8787FF)),
                  ),
                ),
              ),
              dropdownOptions: DropdownOptions(
                  align: DropdownAlign.left,
                  borderRadius: BorderRadius.circular(10)),
              dropdownItemOptions: DropdownItemOptions(
                boxDecoration:
                    BoxDecoration(color: CColors.secondary.withOpacity(0.5)),
                selectedTextStyle: TextStyle(
                  color: CColors.white,
                  fontSize: screenWidth * 0.02,
                ),
                selectedBoxDecoration:
                    BoxDecoration(color: CColors.secondary.withOpacity(0.5)),
              ),
            ),
          ),
          const SizedBox(
            width: CSizes.spaceBtwItems,
          ),
        ],
      ),
    );
  }
}

class DiscountInfoBanner extends StatelessWidget {
  const DiscountInfoBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: CSizes.spaceBtwItems, vertical: CSizes.sm * 1.5),
      decoration: const BoxDecoration(
          gradient:
              LinearGradient(colors: [CColors.primary, CColors.secondary]),
          borderRadius:
              BorderRadius.all(Radius.circular(CSizes.borderRadiusMd))),
      child: const Row(
        children: [
          Spacer(),
          Text("Up to 15% off all services"),
          Spacer(),
          Icon(Icons.chevron_right)
        ],
      ),
    );
  }
}
