import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sneaco_delivery_partner_app/utils/local_storage/local_storage.dart';

import 'my_app.dart';

void main() async {
  /// initialize dependencies
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await LocalStorage.init();
  runApp(MyApp(
    connectivity: Connectivity(),
  ));
}
