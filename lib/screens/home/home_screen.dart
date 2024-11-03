import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:sneaco_delivery_partner_app/screens/account/account_screen.dart';
import 'package:sneaco_delivery_partner_app/screens/home/model/deliveries_model.dart';
import 'package:sneaco_delivery_partner_app/screens/home/provider/delivery_provider.dart';
import 'package:sneaco_delivery_partner_app/screens/map/map_screen.dart';
import 'package:sneaco_delivery_partner_app/utils/constants/color.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/functions/open_google_map.dart';
import '../../common/widgets/footer/footer.dart';
import '../../common/widgets/header/header.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/helpers/helper_functions.dart';
import '../../utils/theme/custom_themes/text_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double curLat = 0.0;
  double curLong = 0.0;

  @override
  Widget build(BuildContext context) {
    // final dp = Provider.of<DeliveryProvider>(context);
    final screenWidth = HelperFunctions.screenWidth(context);
    final screenHeight = HelperFunctions.screenHeight(context);
    return Scaffold(
      backgroundColor: CColors.primaryBackground,
      body: Column(
        children: [
          // Header section displaying orders
          Header(
              title: "Orders",
              logo: CImages.bag,
              screenWidth: screenWidth,
              screenHeight: screenHeight),

          // Date selector for deliveries
          _buildDateSelector(screenWidth, screenHeight),

          // Main content section for deliveries
          Expanded(
            child: Consumer<DeliveryProvider>(
              builder: (context, dp, child) {
                if (_hasNoDeliveries(dp)) {
                  return _buildEmptyOrdersMessage(screenWidth, screenHeight);
                }
                return _buildDeliveriesList(dp, screenWidth, screenHeight);
              },
            ),
          ),
        ],
      ),
      // Footer section with buttons for orders and account
      bottomNavigationBar: Footer(
        screenHeight: screenHeight,
        screenWidth: screenWidth,
        ordersButton: () {},
        accountButton: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const AccountScreen()));
        },
      ),
    );
  }

  deliveryStatusColor(String status) {
    if (status == "Pickup Pending" || status == "Delivery Pending") {
      return {
        "textColor": const Color(0xFFFF5963),
        "backgroundColor": const Color(0xFFFFDEE0),
      };
    } else if (status == "Pickup Failed" || status == "Delivery Failed") {
      return {
        "textColor": const Color(0xFFE81F2B),
        "backgroundColor": const Color(0xFFFEDEE0),
      };
    }
    // else if (status == "Pickup Rescheduled" ||
    //     status == "Delivery Rescheduled") {
    //   return {
    //     "textColor": const Color(0xFF0050AA),
    //     "backgroundColor": const Color(0xFFEAF4FF),
    //   };
    // }
    else if (status == "Pickup Confirmed" || status == "Delivery Confirmed") {
      return {
        "textColor": const Color(0xFFFCF958),
        "backgroundColor": const Color(0xFFFEFEDE),
      };
    } else if (status == "Delivered") {
      return {
        "textColor": const Color(0xFF34A853),
        "backgroundColor": const Color(0xFFEAFFF0),
      };
    } else {
      return {
        "textColor": const Color(0xFF2B2E35),
        "backgroundColor": const Color(0xFFF0F0F0),
      };
    }
  }

  // Builds the date selector for deliveries
  Widget _buildDateSelector(double screenHeight, double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            Provider.of<DeliveryProvider>(context, listen: false)
                .setSelectedValue(context);
          },
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.02,
              vertical: screenHeight * 0.015,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFFD9D9D9),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Consumer<DeliveryProvider>(builder: (_, dp, __) {
              return Text(dp.customDate,
                  style: CustomTextTheme.lightTextTheme.bodyLarge);
            }),
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  // Checks if there are no deliveries for the selected date
  bool _hasNoDeliveries(DeliveryProvider dp) {
    return dp.deliveries[dp.customDate] == null ||
        dp.deliveries[dp.customDate]!.isEmpty ||
        dp.deliveries.isEmpty ||
        !dp.deliveries.containsKey(dp.customDate);
  }

  // Displays a message when there are no orders available
  Widget _buildEmptyOrdersMessage(double screenWidth, double screenHeight) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        SvgPicture.asset(
          CImages.emptyOrdersList,
          width: screenWidth * 0.5,
          height: screenHeight * 0.4,
        ),
        const SizedBox(height: 20),
        const Text(
          "No Orders Available",
          style: TextStyle(
            color: Color(0xFF2B2E35),
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  // Builds the list of deliveries for the selected date
  Widget _buildDeliveriesList(
      DeliveryProvider dp, double screenWidth, double screenHeight) {
    return ListView.builder(
      itemCount: dp.deliveries[dp.customDate]?.length ?? 0,
      itemBuilder: (_, i) {
        final delivery = dp.deliveries[dp.customDate]![i];
        return _buildDeliveryCard(dp, delivery, i, screenWidth, screenHeight);
      },
    );
  }

  // Builds a single delivery card
  Widget _buildDeliveryCard(DeliveryProvider dp, DeliveriesModel delivery,
      int index, double screenWidth, double screenHeight) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFD9D9D9),
            blurRadius: 20,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDeliveryHeader(dp, delivery, index, screenWidth, screenHeight),
          _buildDeliveryDetails(dp, delivery, index, screenWidth, screenHeight),
          _buildExpandCollapseButton(dp, index),
        ],
      ),
    );
  }

  // Builds the header for the delivery card
  Widget _buildDeliveryHeader(DeliveryProvider dp, DeliveriesModel delivery,
      int index, double screenWidth, double screenHeight) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildDeliveryOrderInfo(delivery),
        _buildDeliveryStatus(delivery),
      ],
    );
  }

  // Builds the order information for the delivery card
  Widget _buildDeliveryOrderInfo(DeliveriesModel delivery) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Order No.", style: CustomTextTheme.lightTextTheme.titleMedium),
        Text("#${delivery.deliveryId}",
            style: CustomTextTheme.lightTextTheme.bodySmall),
      ],
    );
  }

  // Builds the status of the delivery
  Widget _buildDeliveryStatus(DeliveriesModel delivery) {
    final statusColor = deliveryStatusColor(delivery.status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: statusColor["backgroundColor"] as Color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        delivery.status,
        style: CustomTextTheme.lightTextTheme.bodySmall?.copyWith(
          color: statusColor["textColor"] as Color,
        ),
      ),
    );
  }

  // Builds the details of the delivery
  Widget _buildDeliveryDetails(DeliveryProvider dp, DeliveriesModel delivery,
      int index, double screenWidth, double screenHeight) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: dp.isExpandedList[index] ? null : 0, // Expand or collapse
      child: dp.isExpandedList[index]
          ? _buildExpandedDetails(dp, delivery, screenWidth, screenHeight)
          : null,
    );
  }

  // Builds the expanded details of the delivery
  Widget _buildExpandedDetails(DeliveryProvider dp, DeliveriesModel delivery,
      double screenWidth, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        const DottedLine(),
        const SizedBox(height: 10),
        _buildUserInfo(
            screenWidth,
            screenHeight,
            delivery.user.userName,
            delivery.user.userLocation.locationAddress,
            CImages.pick,
            delivery.user.userPhone,
            delivery.user.userLocation.locationLatitude,
            delivery.user.userLocation.locationLongitude),
        const SizedBox(height: 10),
        const Divider(),
        const SizedBox(height: 2),
        _buildUserInfo(
            screenWidth,
            screenHeight,
            delivery.laundary.laundaryName,
            delivery.laundary.laundaryLocation.locationAddress,
            CImages.mapPin,
            delivery.laundary.laundaryPhone,
            delivery.laundary.laundaryLocation.locationLatitude,
            delivery.laundary.laundaryLocation.locationLongitude),
        const SizedBox(height: 10),
        _buildPriceInfo(delivery, screenWidth, screenHeight),
        const SizedBox(height: 20),
        _buildConfirmPickupButton(
          delivery.status,
          screenHeight,
          screenWidth,
          delivery.docId,
          delivery.status == "New Order"
              ? delivery.user.userLocation.locationAddress
              : delivery.laundary.laundaryLocation.locationAddress,
          delivery.status == "New Order"
              ? delivery.user.userName
              : delivery.laundary.laundaryName,
          delivery.status == "New Order"
              ? delivery.user.userLocation.locationLatitude
              : delivery.laundary.laundaryLocation.locationLatitude,
          delivery.status == "New Order"
              ? delivery.user.userLocation.locationLongitude
              : delivery.laundary.laundaryLocation.locationLongitude,
          delivery.status == "New Order"
              ? delivery.user.userPhone
              : delivery.laundary.laundaryPhone,
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  // Builds user information in the expanded details
  Widget _buildUserInfo(
      double screenWidth,
      double screenHeight,
      String userName,
      String userAddress,
      String icon,
      String userPhone,
      double latitude,
      double longitude) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SvgPicture.asset(
              CImages.userAlt,
              height: screenHeight * 0.035,
              width: screenWidth * 0.035,
            ),
            const SizedBox(width: 10),
            Text(userName, style: CustomTextTheme.lightTextTheme.titleLarge),
            const Spacer(),
            GestureDetector(
              onTap: () async {
                final Uri launchUri = Uri(
                  scheme: 'tel',
                  path: userPhone,
                );
                await launchUrl(launchUri);
              },
              child: SvgPicture.asset(
                CImages.phone,
                height: screenHeight * 0.035,
                width: screenWidth * 0.035,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            SvgPicture.asset(icon,
                height: screenHeight * 0.025, width: screenWidth * 0.025),
            SizedBox(
              width: screenWidth * 0.035,
            ),
            SizedBox(
              width: screenWidth * 0.5,
              child: Text(userAddress,
                  style: CustomTextTheme.lightTextTheme.bodySmall?.copyWith(
                    color: const Color(0xFF57585A),
                  )),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                openMap(latitude, longitude);
              },
              child: SvgPicture.asset(
                CImages.send,
                height: screenHeight * 0.035,
                width: screenWidth * 0.035,
              ),
            ),
          ],
        )
      ],
    );
  }

  // Builds price information in the expanded details
  Widget _buildPriceInfo(
      DeliveriesModel delivery, double screenWidth, double screenHeight) {
    return Row(
      children: [
        SvgPicture.asset(
          CImages.money,
          height: screenHeight * 0.035,
          width: screenWidth * 0.035,
        ),
        SizedBox(
          width: screenWidth * 0.035,
        ),
        Text("₹ ${delivery.price}",
            style: CustomTextTheme.lightTextTheme.titleMedium),
        SizedBox(
          width: screenWidth * 0.035,
        ),
        SvgPicture.asset(
          CImages.paid,
          height: screenHeight * 0.03,
          width: screenWidth * 0.03,
        ),
        Text("Paid",
            style: CustomTextTheme.lightTextTheme.titleMedium?.copyWith(
              color: const Color(0xFF34A853),
            )),
      ],
    );
  }

  // Button to confirm the pickup of the delivery
  Widget _buildConfirmPickupButton(
      String status,
      double screenHeight,
      double screenWidth,
      String docId,
      String address,
      String name,
      double latitude,
      double longitude,
      String phone) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          if (status == "Completed") {
            return;
          }
          if (_checkNextStatusForButton(status) == "Accept" ||
              _checkNextStatusForButton(status) == "Confirm Pickup") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => MapScreen(
                          address: address,
                          name: name,
                          phone: phone,
                          latitude: latitude,
                          longitude: longitude,
                          curLat: 0.0,
                          curLong: 0.0,
                        )));
          }
          await FirebaseFirestore.instance
              .collection("deliveries")
              .doc(docId)
              .update({
            'status': _setNextStatusForOrder(_checkNextStatusForButton(status))
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              status == "Completed" ? CColors.secondary : CColors.primary,
          foregroundColor: Colors.white,
        ),
        child: Text(
          _checkNextStatusForButton(status),
          style: CustomTextTheme.lightTextTheme.titleMedium?.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // Button to expand/collapse the delivery card
  Widget _buildExpandCollapseButton(DeliveryProvider dp, int index) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        child: Icon(
          dp.isExpandedList[index] ? Icons.expand_less : Icons.expand_more,
        ),
        onTap: () {
          dp.toggleExpand(index); // Toggle the expansion state
        },
      ),
    );
  }

  _checkNextStatusForButton(String status) {
    switch (status) {
      case "New Order":
        return "Accept";
      case "Pickup Pending":
        return "Confirm Pickup";
      case "Delivery Pending":
        return "Confirm Delivery";
      case "Completed":
        return "Completed";
    }
  }

  _setNextStatusForOrder(String value) {
    switch (value) {
      case "Accept":
        return "Pickup Pending";
      case "Confirm Pickup":
        return "Delivery Pending";
      case "Confirm Delivery":
        return "Completed";
    }
  }

  _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Geolocator.openLocationSettings();
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Geolocator.openAppSettings();
      }
    }

    final Position position = await Geolocator.getCurrentPosition();

    curLat = position.latitude;
    curLong = position.longitude;

    log('Current Location: $curLat, $curLong');
  }
}
