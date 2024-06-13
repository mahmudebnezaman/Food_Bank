import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:restuarant_ui/entities/location.dart';
import 'package:restuarant_ui/modal/get_address_from_lat_lng.dart';
import 'package:restuarant_ui/views/dashboard.dart';
import 'package:gap/gap.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart' as coordinates;

import 'package:restuarant_ui/const/images.dart';
import 'package:restuarant_ui/views/location_changer.dart';
import 'package:restuarant_ui/views/widgets/searc_bar.dart';
import 'package:restuarant_ui/views/widgets/store_card.dart';

typedef Location = List<double> Function(dynamic data);

class PageZero extends StatefulWidget {
  const PageZero({super.key});

  @override
  State<PageZero> createState() => _PageZeroState();
}

class _PageZeroState extends State<PageZero> {
  String? _currentAddress;
  Position? _currentPosition;
  double zoomLevel = 15.0;
  bool displayOnly = false;

  late SimpleLocationResult _selectedLocation =
      SimpleLocationResult(28.45306253513271, 81.47338277012638);

  @override
  void initState() {
    super.initState();
    getAddress(context);
  }

  void getAddress(context) async {
    _currentPosition = await getCurrentPosition(context);
    _currentAddress = await getAddressFromLatLng(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
    );
    _selectedLocation = SimpleLocationResult(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
    );
    log('$_currentAddress page 0');
    setState(() {});
  }

  void changeLocation(SimpleLocationResult newAddress) async {
    _selectedLocation = newAddress;
    _currentAddress =
        await getAddressFromLatLng(newAddress.latitude, newAddress.longitude);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
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
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSearchBar(
                  height: height,
                  width: width,
                  bannerText: "Find and Order\nFoods for you.",
                ),
                const Gap(5),
                Row(
                  children: [
                    Text(
                      'Restaurant Near You',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const Spacer(),
                    Text(
                      'View All',
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.bodyMedium!.fontSize,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Dashboard(),
                            ));
                      },
                      child: const StoreCard(),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(
                      addBanner,
                      height: 140,
                      width: double.maxFinite,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  AlertDialog selectMapDialog(BuildContext ctx, String currentLocation) {
    return AlertDialog(
      title: Wrap(
        children: [
          Text(
            currentLocation,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Icon(Icons.location_pin),
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
