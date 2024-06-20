import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:restuarant_ui/const/images.dart';
import 'package:restuarant_ui/control/get_address_from_lat_lng.dart';
import 'package:restuarant_ui/modal/location.dart';
import 'package:restuarant_ui/views/home_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Position? _currentPosition;
  late String? _currentAddress;
  late SimpleLocationResult _selectedLocation;

  Future<void> getAddress(context) async {
    _currentPosition = await getCurrentPosition(context);
    _currentAddress = await getAddressFromLatLng(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
    );
    _selectedLocation = SimpleLocationResult(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
    );
    saveUserAddressToPrefs(_currentAddress.toString(), _selectedLocation);
    setState(() {});
  }

  Future<void> saveUserAddressToPrefs(String address, SimpleLocationResult location) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userAddress', address);
    await prefs.setString('userLocation', jsonEncode(location));
  }

  @override
  void initState() {
    super.initState();
    getAddress(context).then((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const RestaurantHomeView(title: 'Foodiez'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                appIcon,
                height: MediaQuery.sizeOf(context).width * 0.5,
              ),
              // .animate().fade(duration: 2.seconds)
            ),
            const Gap(20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}