import 'package:cloud_firestore/cloud_firestore.dart';

class DeliveriesModel {
  final int deliveryId;
  final String docId;
  final DateTime deliveryDate;
  final DeliveryPartnerModel deliveryPartner;
  final UserModel user;
  final LaundaryModel laundary;
  final String status;
  final num price;

  DeliveriesModel({
    required this.deliveryId,
    required this.docId,
    required this.deliveryPartner,
    required this.user,
    required this.laundary,
    required this.deliveryDate,
    required this.status,
    required this.price,
  });

  factory DeliveriesModel.fromJson(Map<String, dynamic> json, String docId) {
    return DeliveriesModel(
      deliveryId: json['deliveryId'],
      docId: docId,
      deliveryPartner: DeliveryPartnerModel.fromJson(json['deliveryPartner']),
      user: UserModel.fromJson(json['user']),
      laundary: LaundaryModel.fromJson(json['laundary']),
      deliveryDate: (json['deliveryDate'] as Timestamp).toDate(),
      status: json['status'],
      price: json['price'],
    );
  }
}

class DeliveryPartnerModel {
  final String deliveryPartnerId;
  final String deliveryPartnerName;
  final String deliveryPartnerPhone;
  final String deliveryPartnerImage;
  final String deliveryPartnerRating;

  DeliveryPartnerModel({
    required this.deliveryPartnerId,
    required this.deliveryPartnerName,
    required this.deliveryPartnerPhone,
    required this.deliveryPartnerImage,
    required this.deliveryPartnerRating,
  });

  factory DeliveryPartnerModel.fromJson(Map<String, dynamic> json) {
    return DeliveryPartnerModel(
      deliveryPartnerId: json['deliveryPartnerId'],
      deliveryPartnerName: json['deliveryPartnerName'],
      deliveryPartnerPhone: json['deliveryPartnerPhone'],
      deliveryPartnerImage: json['deliveryPartnerImage'],
      deliveryPartnerRating: json['deliveryPartnerRating'],
    );
  }
}

class UserModel {
  final String userId;
  final String userName;
  final String userPhone;
  final String userImage;
  final String userRating;
  final LocationModel userLocation;

  UserModel({
    required this.userId,
    required this.userName,
    required this.userPhone,
    required this.userImage,
    required this.userRating,
    required this.userLocation,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      userName: json['userName'],
      userPhone: json['userPhone'],
      userImage: json['userImage'],
      userRating: json['userRating'],
      userLocation: LocationModel.fromJson(json['userLocation']),
    );
  }
}

class LaundaryModel {
  final String laundaryId;
  final String laundaryName;
  final String laundaryPhone;
  final String laundaryImage;
  final String laundaryRating;
  final LocationModel laundaryLocation;

  LaundaryModel({
    required this.laundaryId,
    required this.laundaryName,
    required this.laundaryPhone,
    required this.laundaryImage,
    required this.laundaryRating,
    required this.laundaryLocation,
  });

  factory LaundaryModel.fromJson(Map<String, dynamic> json) {
    return LaundaryModel(
      laundaryId: json['laundaryId'],
      laundaryName: json['laundaryName'],
      laundaryPhone: json['laundaryPhone'],
      laundaryImage: json['laundaryImage'],
      laundaryRating: json['laundaryRating'],
      laundaryLocation: LocationModel.fromJson(json['laundaryLocation']),
    );
  }
}

class LocationModel {
  final String locationAddress;
  final double locationLatitude;
  final double locationLongitude;
  final String geoHash;

  LocationModel({
    required this.locationAddress,
    required this.locationLatitude,
    required this.locationLongitude,
    required this.geoHash,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      locationAddress: json['locationAddress'],
      locationLatitude: json['locationLatitude'],
      locationLongitude: json['locationLongitude'],
      geoHash: json['geoHash'],
    );
  }
}
