import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sneaco_delivery_partner_app/utils/constants/color.dart';
import 'package:sneaco_delivery_partner_app/utils/constants/image_strings.dart';
import 'package:sneaco_delivery_partner_app/utils/theme/custom_themes/text_theme.dart';

import '../../utils/helpers/helper_functions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _mobileController = TextEditingController();
  bool termAccepted = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = HelperFunctions.screenWidth(context);
    final screenHeight = HelperFunctions.screenHeight(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: screenWidth,
                  height: screenHeight * 0.7,
                  child: SvgPicture.asset(
                    CImages.loginEllipse,
                  ),
                ),
                Positioned(
                  left: 50,
                  right: 50,
                  top: 50,
                  bottom: 50,
                  child: SvgPicture.asset(
                    CImages.loginDeliveryPartner,
                    width: screenWidth * 0.6,
                  ),
                ),
                Positioned(
                  left: 20,
                  bottom: 120,
                  child: Text(
                    "Be a Sneaco Partner",
                    style: CustomTextTheme.lightTextTheme.headlineMedium,
                  ),
                ),
                Positioned(
                  left: 20,
                  bottom: 25,
                  child: Text(
                    "Get a stable monthly\nincome",
                    style: CustomTextTheme.lightTextTheme.headlineLarge,
                  ),
                ),
                Positioned(
                  left: 100,
                  top: 120,
                  child: SvgPicture.asset(
                    CImages.lightGreenCircle,
                    // color: Colors.red,
                  ),
                ),
                Positioned(
                  left: 200,
                  top: 180,
                  child: SvgPicture.asset(
                    CImages.veryLightGreenCircle,
                    // color: Colors.red,
                  ),
                ),
                Positioned(
                  left: 350,
                  top: 120,
                  child: SvgPicture.asset(
                    CImages.whiteCircle,
                    // color: Colors.red,
                  ),
                ),
                Positioned(
                  left: 415,
                  top: 230,
                  child: SvgPicture.asset(
                    CImages.lightGreyCircle,
                    // color: Colors.red,
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 230,
                  child: SvgPicture.asset(
                    CImages.whiteCircle,
                    // color: Colors.red,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.01),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter Mobile Number",
                    style: CustomTextTheme.lightTextTheme.headlineSmall,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextField(
                    controller: _mobileController,
                    decoration: InputDecoration(
                      hintText: "e.g. 9999988888",
                      hintStyle: const TextStyle(
                        color: CColors.textSecondary,
                      ),
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
                    ),
                    cursorColor: CColors.primary,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                          activeColor: CColors.primary,
                          value: termAccepted,
                          onChanged: (value) {
                            setState(() {
                              termAccepted = !termAccepted;
                            });
                          }),
                      Text(
                        "By signing up I agree to the Terms of use and\nPrivacy Policy.",
                        style: CustomTextTheme.lightTextTheme.bodySmall,
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: CColors.primary,
                      disabledBackgroundColor: Colors.grey,
                      disabledForegroundColor: Colors.white,
                      side: const BorderSide(color: Colors.transparent),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      fixedSize: Size(screenWidth, screenHeight * 0.06),
                    ),
                    child: const Text("Send OTP"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
