import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:restuarant_ui/const/images.dart';
import 'package:restuarant_ui/const/storedetails.dart';
import 'package:restuarant_ui/views/location_changer.dart';
import 'package:restuarant_ui/views/widgets/banner_card.dart';
import 'package:restuarant_ui/views/widgets/search_bar.dart';
import 'package:restuarant_ui/views/widgets/store_card.dart';
import 'package:restuarant_ui/modal/location.dart';
import 'package:restuarant_ui/control/get_address_from_lat_lng.dart';
import 'package:restuarant_ui/views/store_dashboard.dart';

typedef Location = List<double> Function(dynamic data);

class PageZero extends StatefulWidget {
  const PageZero({super.key});

  @override
  State<PageZero> createState() => _PageZeroState();
}

class _PageZeroState extends State<PageZero> {
  String? _currentAddress;
  double zoomLevel = 15.0;
  bool displayOnly = false;

  late SimpleLocationResult _selectedLocation =
      SimpleLocationResult(28.45306253513271, 81.47338277012638);

  @override
  void initState() {
    super.initState();
    storeNames();
  }

  Future<void> loadUserAddressFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _currentAddress = prefs.getString('userAddress');
    _selectedLocation = SimpleLocationResult.fromJson(
      jsonDecode(prefs.getString('userLocation') ?? '{}'),
    );
  }

  void changeLocation(SimpleLocationResult newAddress) async {
    _selectedLocation = newAddress;
    _currentAddress =
        await getAddressFromLatLng(newAddress.latitude, newAddress.longitude);
    saveUserAddressToPrefs(_currentAddress.toString(), _selectedLocation);
    setState(() {});
  }
    Future<void> saveUserAddressToPrefs(String address, SimpleLocationResult location) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userAddress', address);
    await prefs.setString('userLocation', jsonEncode(location));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: loadUserAddressFromPrefs(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Text(_currentAddress ?? 'Detecting Location'),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => selectMapDialog(
                          ctx, _currentAddress ?? 'Detecting Location'),
                    );
                  },
                  icon: const Icon(Icons.location_pin),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomSearchBar(),
                  buildOrderTypeRow(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 8.0,
                    ),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Restaurant Near You',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const Gap(5),
                            Image.asset(
                              fireImage,
                              height: 20,
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          'View All',
                          style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .fontSize,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.27,
                    child: Visibility(
                      visible: (storeDetails[_currentAddress] != null),
                      replacement: Image.asset(comingSoonImage),
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: storeDetails[_currentAddress]?.length ?? 2,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StoreDashboard(
                                    store: storeDetails[_currentAddress]![index],
                                  ),
                                ));
                          },
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.4,
                            child: StoreCard(
                              address: storeDetails[_currentAddress]![index]
                                  .address,
                              storeImage: storeDetails[_currentAddress]![index]
                                  .storeBanner,
                              storeName: storeDetails[_currentAddress]![index]
                                  .storeName,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      log(storeDetails[_currentAddress] as String);
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(
                        addBanner,
                        height: 140,
                        width: double.maxFinite,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: (storeDetails[_currentAddress] != null),
                    replacement: Image.asset(comingSoonImage),
                    child: GridView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8.0,
                              crossAxisSpacing: 8.0,
                              mainAxisExtent: 250),
                      padding: const EdgeInsets.all(8.0),
                      itemCount: storeDetails[_currentAddress]?.length ?? 2,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StoreDashboard(
                                    store: storeDetails[_currentAddress]![index],
                                  ),
                                ));
                          },
                          child: StoreCard(
                            address: storeDetails[_currentAddress]![index]
                                .address,
                            storeImage: storeDetails[_currentAddress]![index]
                                .storeBanner,
                            storeName: storeDetails[_currentAddress]![index]
                                .storeName,
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  AlertDialog selectMapDialog(BuildContext ctx, String currentLocation) {
    return AlertDialog(
      title: Wrap(
        children: [
          const Icon(Icons.location_pin),
          Text(
            currentLocation,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
      content: _showMap(),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LocationChanger(
                    selectedLocation: _selectedLocation,
                    onLocationSaved: changeLocation,
                  ),
                ));
          },
          child: const Text('Change Location'),
        ),
      ],
    );
  }

  Widget _showMap() {
    return SizedBox(
      height: 150,
      width: double.maxFinite,
      child: FlutterMap(
        options: MapOptions(
          initialCenter: _selectedLocation.getLatLng(),
          initialZoom: zoomLevel,
          interactionOptions: const InteractionOptions(
            flags: InteractiveFlag.none,
          ),
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          ),
          MarkerLayer(markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: _selectedLocation.getLatLng(),
              child: const Icon(
                Icons.location_pin,
                color: Color.fromARGB(255, 255, 7, 7),
              ),
            ),
          ])
        ],
      ),
    );
  }
}
