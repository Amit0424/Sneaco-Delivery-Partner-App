import 'package:flutter/material.dart';
import 'package:sneaco_delivery_partner_app/screens/profile/model/profile_model.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileModel profile = ProfileModel(
    id: "1",
    firstName: "John",
    lastName: "Doe",
    email: "mail@website.com",
    mobile: "1234567890",
    whatsapp: "1234567890",
    imageUrl: "https://www.google.com",
    dateOfBirth: DateTime.now(),
    city: "New York",
    rating: "4.89",
  );

  void updateProfile(ProfileModel profileModel) {
    profile = profileModel;
  }
}
