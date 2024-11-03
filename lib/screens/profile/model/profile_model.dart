import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String mobile;
  final String whatsapp;
  final String imageUrl;
  final DateTime dateOfBirth;
  final String city;
  final String rating;

  ProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile,
    required this.whatsapp,
    required this.imageUrl,
    required this.dateOfBirth,
    required this.city,
    required this.rating,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> map, String id) {
    return ProfileModel(
      id: id,
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      mobile: map['mobile'],
      whatsapp: map['whatsapp'],
      imageUrl: map['profileUrl'],
      dateOfBirth: (map['dob'] as Timestamp).toDate(),
      city: map['city'],
      rating: map['rating'],
    );
  }
}
