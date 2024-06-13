import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

Future<String?> getAddressFromLatLng(double latitude, double longitude) async {
  String? address = 'Location Permission Denied';
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placemarks[0];
    address = '${place.subAdministrativeArea}, ${place.locality}';
    log(address.toString());
  } catch (e) {
    debugPrint(e.toString());
  }
  return address;
}

Future<Position?> getCurrentPosition(BuildContext ctx) async {
  final hasPermission = await handleLocationPermission(ctx);

  if (!hasPermission) return null;
  try {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;
  } catch (e) {
    debugPrint('Error is $e');
    return null;
  }
}

Future<bool> handleLocationPermission(BuildContext ctx) async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
        content: Text('Location services are disabled. Please enable the services')));
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied')));
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
        content: Text('Location permissions are permanently denied, we cannot request permissions.')));
    return false;
  }
  return true;
}
