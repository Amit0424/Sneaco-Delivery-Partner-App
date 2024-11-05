import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sneaco_delivery_partner_app/common/functions/date_time_to_string.dart';

import '../../../utils/constants/color.dart';
import '../model/deliveries_model.dart';

class DeliveryProvider extends ChangeNotifier {
  String customDate =
      "${DateTime.now().day < 10 ? "0${DateTime.now().day}" : DateTime.now().day}/${DateTime.now().month < 10 ? "0${DateTime.now().month}" : DateTime.now().month}/${DateTime.now().year}";
  DateTime startDate = DateTime.utc(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);
  DateTime endDate = DateTime.utc(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, 23, 59, 59);
  Map<String, List<DeliveriesModel>> deliveries = {};
  List<bool> isExpandedList = [];

  DeliveryProvider() {
    getDeliveries();
  }

  void setSelectedValue(BuildContext context) {
    showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      initialDate: startDate,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: CColors.primary,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    ).then((value) async {
      if (value != null) {
        startDate = DateTime.utc(value.year, value.month, value.day, 0, 0, 0);
        endDate = DateTime.utc(value.year, value.month, value.day, 23, 59, 59);
        customDate = dateTimeToString(value);

        if (!deliveries.containsKey(customDate)) {
          await getDeliveries();
        }
        isExpandedList = List<bool>.filled(
            ((deliveries[customDate] ?? []) as List).length, false);
        notifyListeners();
      }
    });
  }

  getDeliveries() async {
    await FirebaseFirestore.instance
        .collection("deliveries")
        .where("deliveryPartner.deliveryPartnerId",
            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        // .where("deliveryDate", isGreaterThanOrEqualTo: startDate)
        // .where("deliveryDate", isLessThanOrEqualTo: endDate)
        .get()
        .then((value) {
      log('Get Deliveries');
      deliveries[customDate] = value.docs
          .map((e) => DeliveriesModel.fromJson(e.data(), e.id))
          .toList();
      listenToDeliveries();
      isExpandedList =
          List<bool>.filled((deliveries[customDate] as List).length, false);
      notifyListeners();
    }).catchError((e) {
      log(e.toString());
    });
  }

  listenToDeliveries() {
    return FirebaseFirestore.instance
        .collection("deliveries")
        .where("deliveryPartner.deliveryPartnerId",
            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        // .where("deliveryDate", isGreaterThanOrEqualTo: startDate)
        // .where("deliveryDate", isLessThanOrEqualTo: endDate)
        .snapshots()
        .listen((event) {
      deliveries[customDate] = event.docs
          .map((e) => DeliveriesModel.fromJson(e.data(), e.id))
          .toList();
      isExpandedList =
          List<bool>.filled((deliveries[customDate] as List).length, false);
      notifyListeners();
    }).onError((handleError) {
      log(handleError.toString());
    });
  }

  void toggleExpand(int index) {
    isExpandedList[index] = !isExpandedList[index];
    notifyListeners();
  }
}
