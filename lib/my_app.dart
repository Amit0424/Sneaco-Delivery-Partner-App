import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneaco_delivery_partner_app/screens/authentication/login_screen.dart';
import 'package:sneaco_delivery_partner_app/screens/home/home_screen.dart';
import 'package:sneaco_delivery_partner_app/screens/profile/profile_screen.dart';
import 'package:sneaco_delivery_partner_app/screens/profile/provider/profile_provider.dart';
import 'package:sneaco_delivery_partner_app/utils/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.connectivity});

  final Connectivity connectivity;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Sneaco Delivery Partner App',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.light,
          home: AuthService().handleAuth(),
        ));
  }
}

class AuthService {
  //Handles Authentication
  handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user == null) {
            return const LoginScreen();
          } else {
            return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('deliveryPartner')
                  .doc(user.uid)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    DocumentSnapshot documentSnapshot = snapshot.data;
                    if (documentSnapshot.exists) {
                      return HomeScreen();
                    } else {
                      return const ProfileScreen();
                    }
                  }
                }
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            );
          }
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
