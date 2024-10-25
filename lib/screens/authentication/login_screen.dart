import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sneaco_delivery_partner_app/common/widgets/text_field/custom_text_field.dart';
import 'package:sneaco_delivery_partner_app/screens/authentication/otp_verification.dart';
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
                  left: screenWidth * 0.1,
                  right: screenWidth * 0.1,
                  top: screenHeight * 0.05,
                  bottom: screenHeight * 0.05,
                  child: SvgPicture.asset(
                    CImages.loginDeliveryPartner,
                    width: screenWidth * 0.6,
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.055,
                  bottom: screenHeight * 0.13,
                  child: Text(
                    "Be a Sneaco Partner",
                    style: CustomTextTheme.lightTextTheme.headlineMedium,
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.055,
                  bottom: screenHeight * 0.03,
                  child: Text(
                    "Get a stable monthly\nincome",
                    style: CustomTextTheme.lightTextTheme.headlineLarge,
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.3,
                  top: screenHeight * 0.14,
                  child: SvgPicture.asset(
                    CImages.lightGreenCircle,
                    // color: Colors.red,
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.5,
                  top: screenHeight * 0.2,
                  child: SvgPicture.asset(
                    CImages.veryLightGreenCircle,
                    // color: Colors.red,
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.8,
                  top: screenHeight * 0.14,
                  child: SvgPicture.asset(
                    CImages.whiteCircle,
                    // color: Colors.red,
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.925,
                  top: screenHeight * 0.25,
                  child: SvgPicture.asset(
                    CImages.lightGreyCircle,
                    // color: Colors.red,
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.055,
                  top: screenHeight * 0.25,
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
                    style: CustomTextTheme.lightTextTheme.titleMedium,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  CustomTextField(
                    controller: _mobileController,
                    readOnly: false,
                    hintText: "e.g. 9999988888",
                    inputFormatter: FilteringTextInputFormatter.digitsOnly,
                    onSubmitted: () {
                      if (_mobileController.text.length == 10 && termAccepted) {
                        sendOtp();
                      }
                    },
                    keyboardType: TextInputType.number,
                    errorText: "Enter a valid mobile number",
                    minLength: 10,
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
                    onPressed: sendOtp,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: CColors.primary,
                      disabledBackgroundColor: Colors.grey,
                      disabledForegroundColor: Colors.white,
                      side: const BorderSide(color: Colors.transparent),
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
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

  sendOtp() {
    if (_mobileController.text.length == 10 && termAccepted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpVerification(
            phoneNumber: _mobileController.text,
          ),
        ),
      );
    } else if (_mobileController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a mobile number."),
        ),
      );
    } else if (_mobileController.text.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid mobile number."),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please accept the terms and conditions."),
        ),
      );
    }
  }
}
