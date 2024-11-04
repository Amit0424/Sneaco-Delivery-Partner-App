import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:sneaco_delivery_partner_app/utils/constants/image_strings.dart';
import 'package:sneaco_delivery_partner_app/utils/helpers/helper_functions.dart';
import 'package:sneaco_delivery_partner_app/utils/theme/custom_themes/text_theme.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/functions/open_google_map.dart';
import '../../utils/constants/color.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key,
    required this.address,
    required this.name,
    required this.phone,
    required this.latitude,
    required this.longitude,
    required this.curLat,
    required this.curLong});

  final String address;
  final String name;
  final String phone;
  final double latitude;
  final double longitude;
  final double curLat;
  final double curLong;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  Position? _currentPosition;
  Set<Polyline> _polylines = {};
  LatLng _destination = LatLng(37.7749, -122.4194); // San Francisco for example

  @override
  void initState() {
    _destination = LatLng(widget.latitude, widget.longitude);
    super.initState();
    _initRoute();
  }

  // Step 1: Get Current Location
  Future<void> _getCurrentLocation() async {
    _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {});
  }

  // Step 2: Fetch Route Coordinates from Directions API
  Future<List<LatLng>> _getRouteCoordinates(LatLng start, LatLng end) async {
    const apiKey = 'AIzaSyAS8jsRdSwGoyZGirO8twlAOcDclapcsiM';
    final url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${start
        .latitude},${start.longitude}&destination=${end.latitude},${end
        .longitude}&key=$apiKey';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);

    log(data.toString());

    if (data['status'] == 'OK') {
      return _decodePolyline(data['routes'][0]['overview_polyline']['points']);
    } else {
      throw Exception('Failed to load directions');
    }
  }

  List<LatLng> _decodePolyline(String polyline) {
    List<LatLng> points = [];
    int index = 0,
        len = polyline.length;
    int lat = 0,
        lng = 0;

    while (index < len) {
      int b,
          shift = 0,
          result = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }

  // Step 3: Draw the Route on the Map
  Future<void> _initRoute() async {
    await _getCurrentLocation();
    final routePoints = await _getRouteCoordinates(
      LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
      _destination,
    );

    final Polyline polyline = Polyline(
      polylineId: const PolylineId("route"),
      color: Colors.blue,
      points: routePoints,
      width: 5,
    );

    setState(() {
      _polylines.add(polyline);
    });

    _mapController?.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: routePoints.first,
          northeast: routePoints.last,
        ),
        50.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = HelperFunctions.screenWidth(context);
    final screenHeight = HelperFunctions.screenHeight(context);
    return Scaffold(
      body: _currentPosition == null
          ? const Center(
        child: CircularProgressIndicator(
          color: CColors.primary,
        ),
      )
          : Column(
        children: [
          SizedBox(
            width: screenWidth,
            height: screenHeight * 0.7,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.latitude, widget.longitude),
                zoom: 14.4746,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('1'),
                  position: LatLng(widget.latitude, widget.longitude),
                  infoWindow: InfoWindow(
                      title: widget.name, snippet: widget.phone),
                ),
              },
              polylines: _polylines,
              onMapCreated: (controller) => _mapController = controller,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 20),
              SvgPicture.asset(CImages.userAlt),
              const SizedBox(width: 10),
              Text(
                widget.name,
                style: CustomTextTheme.lightTextTheme.headlineMedium,
              ),
              const SizedBox(width: 30),
              GestureDetector(
                onTap: () async {
                  final Uri launchUri = Uri(
                    scheme: 'tel',
                    path: widget.phone,
                  );
                  await launchUrl(launchUri);
                },
                child: SvgPicture.asset(CImages.phone),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 20),
              SvgPicture.asset(CImages.mapPin),
              const SizedBox(width: 10),
              SizedBox(
                width: screenWidth * 0.7,
                child: Text(
                  widget.address,
                  style: CustomTextTheme.lightTextTheme.headlineSmall,
                ),
              ),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ElevatedButton(
              onPressed: () {
                openMap(widget.latitude, widget.longitude);
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(CImages.sendAlt),
                  const SizedBox(width: 15),
                  Text(
                    'Start',
                    style: CustomTextTheme.lightTextTheme.titleSmall
                        ?.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
