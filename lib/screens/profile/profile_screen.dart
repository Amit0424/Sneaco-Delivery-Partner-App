import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_geohash/dart_geohash.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sneaco_delivery_partner_app/common/widgets/text_field/custom_text_field.dart';
import 'package:sneaco_delivery_partner_app/utils/helpers/helper_functions.dart';

import '../../utils/constants/color.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/theme/custom_themes/text_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _whatsappController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  DateTime? picked;
  String _profileUrl = "";
  bool _isImageUploading = false;
  bool _isDataUploading = false;
  double _latitude = 0.0;
  double _longitude = 0.0;
  String geoHash = "";

  @override
  void initState() {
    _mobileController.text =
        FirebaseAuth.instance.currentUser?.phoneNumber!.split("+91").last ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = HelperFunctions.screenWidth(context);
    final screenHeight = HelperFunctions.screenHeight(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  Text(
                    "Personal information",
                    style: CustomTextTheme.lightTextTheme.headlineMedium,
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Text(
                    "Enter the details below so we can get to know and serve you better",
                    style:
                        CustomTextTheme.lightTextTheme.headlineSmall?.copyWith(
                      color: const Color(0xff57585A),
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.015,
                  ),
                  Text(
                    "First Name",
                    style: CustomTextTheme.lightTextTheme.titleMedium,
                  ),
                  SizedBox(
                    height: screenHeight * 0.005,
                  ),
                  CustomTextField(
                    controller: _firstNameController,
                    readOnly: false,
                    hintText: "Please enter first name",
                    inputFormatter:
                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                    onSubmitted: () {},
                    keyboardType: TextInputType.name,
                    errorText: "Enter a valid first name",
                    minLength: 3,
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Text(
                    "Last Name",
                    style: CustomTextTheme.lightTextTheme.titleMedium,
                  ),
                  SizedBox(
                    height: screenHeight * 0.005,
                  ),
                  CustomTextField(
                    controller: _lastNameController,
                    readOnly: false,
                    hintText: "Please enter last name",
                    inputFormatter:
                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                    onSubmitted: () {},
                    keyboardType: TextInputType.text,
                    errorText: "Enter a valid last name",
                    minLength: 3,
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Text(
                    "Date of Birth",
                    style: CustomTextTheme.lightTextTheme.titleMedium,
                  ),
                  SizedBox(
                    height: screenHeight * 0.005,
                  ),
                  CustomTextField(
                    onTap: () async {
                      picked = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(DateTime.now().year - 18,
                            DateTime.now().month, DateTime.now().day),
                        initialDate: DateTime(DateTime.now().year - 18,
                            DateTime.now().month, DateTime.now().day),
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: CColors.primary,
                                // Header background color
                                onPrimary: Colors.white,
                                // Header text color
                                onSurface: Colors.black, // Body text color
                              ),
                              dialogBackgroundColor: Colors
                                  .white, // Background color of the dialog
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (picked != null) {
                        _dobController.text =
                            "${picked!.day < 10 ? "0${picked!.day}" : picked!.day}-${picked!.month < 10 ? "0${picked!.month}" : picked!.month}-${picked!.year}";
                      }
                    },
                    controller: _dobController,
                    readOnly: true,
                    hintText: "dd-mm-yyyy",
                    inputFormatter:
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
                    onSubmitted: () {},
                    suffixIcon: CImages.calender,
                    keyboardType: TextInputType.datetime,
                    errorText: "Enter a valid date of birth",
                    minLength: 10,
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Text(
                    "Primary mobile number",
                    style: CustomTextTheme.lightTextTheme.titleMedium,
                  ),
                  SizedBox(
                    height: screenHeight * 0.005,
                  ),
                  CustomTextField(
                    controller: _mobileController,
                    readOnly: true,
                    hintText: "e.g. 9999988888",
                    inputFormatter:
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
                    onSubmitted: () {},
                    suffixIcon: CImages.check,
                    keyboardType: TextInputType.phone,
                    errorText: "Enter a valid mobile number",
                    minLength: 10,
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Text(
                    "WhatsApp number",
                    style: CustomTextTheme.lightTextTheme.titleMedium,
                  ),
                  SizedBox(
                    height: screenHeight * 0.005,
                  ),
                  CustomTextField(
                    controller: _whatsappController,
                    readOnly: false,
                    hintText: "e.g. 9999988888",
                    inputFormatter: FilteringTextInputFormatter.digitsOnly,
                    onSubmitted: () {},
                    keyboardType: TextInputType.phone,
                    errorText: "Enter a valid WhatsApp number",
                    minLength: 10,
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Text(
                    "City",
                    style: CustomTextTheme.lightTextTheme.titleMedium,
                  ),
                  SizedBox(
                    height: screenHeight * 0.005,
                  ),
                  CustomTextField(
                    controller: _cityController,
                    readOnly: false,
                    hintText: "e.g. Jaipur",
                    inputFormatter:
                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                    onSubmitted: () {},
                    suffixIcon: CImages.location,
                    onTapOnSuffixIcon: () {
                      _getCurrentLocation();
                      // FirebaseAuth.instance.signOut();
                    },
                    keyboardType: TextInputType.text,
                    errorText: "Enter a valid city",
                    minLength: 3,
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Text(
                    "Your profile picture",
                    style: CustomTextTheme.lightTextTheme.titleMedium,
                  ),
                  SizedBox(
                    height: screenHeight * 0.005,
                  ),
                  DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(12),
                    padding: const EdgeInsets.all(6),
                    dashPattern: const [3, 5],
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: SizedBox(
                        height: screenHeight * 0.1,
                        width: screenWidth,
                        child: Row(
                          children: [
                            SizedBox(
                              width: screenWidth * 0.04,
                            ),
                            SizedBox(
                              height: screenHeight * 0.07,
                              width: screenWidth * 0.15,
                              child: _isImageUploading
                                  ? const Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: CircularProgressIndicator(
                                        color: CColors.primary,
                                      ),
                                    )
                                  : _profileUrl.isEmpty
                                      ? SvgPicture.asset(
                                          CImages.user,
                                        )
                                      : Image.network(
                                          _profileUrl,
                                          fit: BoxFit.cover,
                                        ),
                            ),
                            SizedBox(
                              width: screenWidth * 0.09,
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (_profileUrl.isEmpty) {
                                  setState(() {
                                    _isImageUploading = true;
                                  });
                                  _profileUrl = await _uploadImage() ?? "";
                                } else {
                                  setState(() {
                                    _profileUrl = "";
                                  });
                                }
                              },
                              child: Container(
                                height: screenHeight * 0.05,
                                width: screenWidth * 0.5,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: const Color(0xffBBE5CB),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SvgPicture.asset(
                                      CImages.camera,
                                    ),
                                    Text(
                                      _isImageUploading
                                          ? "Uploading"
                                          : _profileUrl.isEmpty
                                              ? "Upload Photo"
                                              : "Uploaded",
                                      style: CustomTextTheme
                                          .lightTextTheme.titleSmall
                                          ?.copyWith(
                                        color: CColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (_profileUrl.isEmpty)
                    SizedBox(height: screenHeight * 0.005),
                  if (_profileUrl.isEmpty)
                    Text("Please upload a clear photo of yourself",
                        style:
                            CustomTextTheme.lightTextTheme.bodySmall?.copyWith(
                          color: CColors.error,
                        )),
                  SizedBox(height: screenHeight * 0.02),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate() &&
                          _profileUrl.isNotEmpty) {
                        // If the form is valid, save the input
                        _formKey.currentState!.save();
                        setState(() {
                          _isDataUploading = true;
                        });
                        final uid = FirebaseAuth.instance.currentUser!.uid;
                        // Upload the data to the server
                        await FirebaseFirestore.instance
                            .collection('deliveryPartners')
                            .doc(uid)
                            .set({
                          'firstName': _firstNameController.text,
                          'lastName': _lastNameController.text,
                          'dob': picked,
                          'mobile': _mobileController.text,
                          'whatsapp': _whatsappController.text,
                          'city': _cityController.text,
                          'profileUrl': _profileUrl,
                          'latitude': _latitude,
                          'longitude': _longitude,
                          'geoHash': geoHash,
                        }).then((value) {
                          setState(() {
                            _isDataUploading = false;
                          });
                        }).catchError((error) {
                          setState(() {
                            _isDataUploading = false;
                          });
                          log('Error occurred while saving data: $error');
                        });
                      }
                    },
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
                    child: _isDataUploading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text("Submit"),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Geolocator.openLocationSettings();
      return;
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Open the app settings to enable permissions
        Geolocator.openAppSettings();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Open the app settings to enable permissions
      Geolocator.openAppSettings();
      return;
    }

    // Get the current location
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );

    _latitude = position.latitude;
    _longitude = position.longitude;
    GeoHasher geoHasher = GeoHasher();
    geoHash = geoHasher.encode(_latitude, _longitude, precision: 9);

    // Get the address based on the latitude and longitude
    _getAddressFromLatLng(position.latitude, position.longitude);
  }

  Future<void> _getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];

        _cityController.text = place.locality ?? 'Unknown';
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // Function to request camera permission
  Future<bool> _requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isDenied || status.isPermanentlyDenied) {
      status = await Permission.camera.request();
    }
    return status.isGranted;
  }

  _uploadImage() async {
    // Request permission before accessing the camera
    bool permissionGranted = await _requestCameraPermission();
    if (!permissionGranted) {
      // Open the app settings to enable permissions
      await openAppSettings();
      return;
    }
    try {
      final ImagePicker picker = ImagePicker();
      XFile? imageFile;
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 600,
        maxHeight: 800,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 50,
      );

      if (pickedFile != null) {
        imageFile = pickedFile;

        _uploadImageToFirebase(File(imageFile.path));
      } else {
        setState(() {
          _isImageUploading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isImageUploading = false;
      });
      log('Error occurred while capturing image: $e');
    }
  }

  Future<void> _uploadImageToFirebase(File imageFile) async {
    try {
      // Create a unique file name for the image
      String fileName = imageFile.path.split('/').last;
      // Reference to the Firebase storage
      Reference storageRef = FirebaseStorage.instance.ref().child(
          '${FirebaseAuth.instance.currentUser!.uid}/profileImages/$fileName');

      // Upload the image file
      UploadTask uploadTask = storageRef.putFile(imageFile);

      // Wait until the file is uploaded
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);

      // Get the download URL
      String downloadUrl = await snapshot.ref.getDownloadURL();

      setState(() {
        _profileUrl = downloadUrl;
        _isImageUploading = false;
      });

      log('Image uploaded successfully. Download URL: $downloadUrl');
    } catch (e) {
      setState(() {
        _isImageUploading = false;
      });

      log('Error occurred while uploading image: $e');
    }
  }
}
