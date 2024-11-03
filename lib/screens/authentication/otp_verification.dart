import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../../utils/constants/color.dart';
import '../../utils/helpers/helper_functions.dart';
import '../../utils/theme/custom_themes/text_theme.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? verificationId;

  @override
  void initState() {
    _requestOTP(widget.phoneNumber);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = HelperFunctions.screenWidth(context);
    final screenHeight = HelperFunctions.screenHeight(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Text(
                "Enter OTP to verify",
                style: CustomTextTheme.lightTextTheme.headlineMedium,
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              RichText(
                text: TextSpan(
                  text: "A 6 digit OTP has been sent to your phone number ",
                  style: CustomTextTheme.lightTextTheme.headlineSmall?.copyWith(
                    color: const Color(0xff57585A),
                  ),
                  children: [
                    TextSpan(
                      text: "+91 ${widget.phoneNumber}  ",
                      style: CustomTextTheme.lightTextTheme.headlineSmall
                          ?.copyWith(
                        color: const Color(0xff2B2E35),
                      ),
                    ),
                    TextSpan(
                      text: "Change",
                      style: CustomTextTheme.lightTextTheme.headlineSmall
                          ?.copyWith(
                        color: CColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Text(
                "Enter OTP Text",
                style: CustomTextTheme.lightTextTheme.headlineSmall?.copyWith(
                  color: const Color(0xff57585A),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              OtpTextField(
                numberOfFields: 6,
                keyboardType: TextInputType.number,
                borderColor: const Color(0xffE5E5E5),
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                focusedBorderColor: CColors.primary,
                cursorColor: CColors.primary,
                showFieldAsBox: true,
                onCodeChanged: (String code) {},
                onSubmit: (String verificationCode) {
                  _verifyOTP(verificationCode);
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              ElevatedButton(
                onPressed: () {
                  _verifyOTP("123456");
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: CColors.primary,
                  disabledBackgroundColor: Colors.grey,
                  disabledForegroundColor: Colors.white,
                  side: const BorderSide(color: Colors.transparent),
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  fixedSize: Size(screenWidth, screenHeight * 0.06),
                ),
                child: const Text(
                  "Verify OTP",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _requestOTP(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: "+91$phoneNumber",
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-retrieval or instant verification
        await _auth.signInWithCredential(credential);
        log("Phone number automatically verified and user signed in: ${_auth.currentUser?.uid}");
      },
      verificationFailed: (FirebaseAuthException e) {
        log("Verification failed: ${e.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        this.verificationId = verificationId;
        log("Code sent to $phoneNumber, $verificationId, $resendToken");
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        this.verificationId = verificationId;
      },
    );
  }

  void _verifyOTP(String otp) async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: otp,
      );
      await _auth.signInWithCredential(credential).then((value) {
        Navigator.of(context).pop();
      });

      log("User signed in: ${_auth.currentUser?.uid}");
    } catch (e) {
      log("Failed to verify OTP: $e");
    }
  }
}
