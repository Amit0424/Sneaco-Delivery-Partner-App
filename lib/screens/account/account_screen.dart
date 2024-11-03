import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sneaco_delivery_partner_app/common/widgets/footer/footer.dart';
import 'package:sneaco_delivery_partner_app/common/widgets/header/header.dart';
import 'package:sneaco_delivery_partner_app/common/widgets/option/option.dart';
import 'package:sneaco_delivery_partner_app/screens/profile/profile_screen.dart';
import 'package:sneaco_delivery_partner_app/screens/profile/provider/profile_provider.dart';
import 'package:sneaco_delivery_partner_app/utils/constants/image_strings.dart';
import 'package:sneaco_delivery_partner_app/utils/helpers/helper_functions.dart';
import 'package:sneaco_delivery_partner_app/utils/theme/custom_themes/text_theme.dart';

import '../../utils/constants/color.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    final ProfileProvider pp = Provider.of<ProfileProvider>(context);
    final screenWidth = HelperFunctions.screenWidth(context);
    final screenHeight = HelperFunctions.screenHeight(context);
    return Scaffold(
      backgroundColor: CColors.primaryBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(
                logo: CImages.account,
                title: "Account",
                screenHeight: screenHeight,
                screenWidth: screenWidth),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        // clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(500)),
                            border: Border.all(color: CColors.secondary)),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          maxRadius: 50,
                          foregroundImage:
                              CachedNetworkImageProvider(pp.profile.imageUrl),
                          backgroundImage: const CachedNetworkImageProvider(
                              "https://firebasestorage.googleapis.com/v0/b/sceaco-65af5.appspot.com/o/constantImages%2Fuser.png?alt=media&token=a8ccc1e7-5d35-44a5-be9f-09a863f115cf",
                              // maxHeight: 1024,
                              // maxWidth: 1024,
                              scale: 1100),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(CImages.userAlt),
                              SizedBox(
                                width: screenWidth * 0.01,
                              ),
                              Text(
                                "${pp.profile.firstName} ${pp.profile.lastName}",
                                style:
                                    CustomTextTheme.lightTextTheme.titleSmall,
                              ),
                              SizedBox(
                                width: screenWidth * 0.02,
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Row(
                                  children: [
                                    Text(pp.profile.rating),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    SvgPicture.asset(CImages.star)
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: screenWidth * 0.015,
                              ),
                              SvgPicture.asset(CImages.phoneAlt),
                              SizedBox(
                                width: screenWidth * 0.015,
                              ),
                              Text(
                                pp.profile.mobile,
                                style:
                                    CustomTextTheme.lightTextTheme.titleSmall,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(CImages.mail),
                              SizedBox(
                                width: screenWidth * 0.01,
                              ),
                              Text(
                                pp.profile.email,
                                style:
                                    CustomTextTheme.lightTextTheme.titleSmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Options",
                      style: CustomTextTheme.lightTextTheme.headlineSmall
                          ?.copyWith(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Option(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ProfileScreen(
                                    firstName: pp.profile.firstName,
                                    lastName: pp.profile.lastName,
                                    city: pp.profile.city,
                                    whatsapp: pp.profile.whatsapp,
                                    email: pp.profile.email,
                                    imageUrl: pp.profile.imageUrl,
                                    dob: pp.profile.dateOfBirth,
                                  )));
                    },
                    title: "Edit Profile",
                    icon: CImages.account,
                  ),
                  Option(
                    onTap: () {},
                    title: "Alloted Area",
                    icon: CImages.favoriteLocation,
                  ),
                  Option(
                    onTap: () {},
                    title: "Refer and Earn",
                    icon: CImages.gift,
                  ),
                  Option(
                    onTap: () {},
                    title: "Support",
                    icon: CImages.support,
                  ),
                  Option(
                    onTap: () {},
                    title: "FAQ",
                    icon: CImages.question,
                  ),
                  Option(
                    onTap: () {},
                    title: "Terms and Condition",
                    icon: CImages.termsCondition,
                  ),
                  Option(
                      onTap: () {},
                      title: "Privacy Policy",
                      icon: CImages.privacy),
                  Option(
                    onTap: () {},
                    title: "Ask For Leave",
                    icon: CImages.message,
                  ),
                  Option(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut().then((value) {
                        Navigator.pop(context);
                      });
                    },
                    title: "Log Out",
                    icon: CImages.logOut,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Footer(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          ordersButton: () {
            Navigator.pop(context);
          },
          accountButton: () {}),
    );
  }
}
