// import 'dart:developer';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:restuarant_ui/entities/location.dart';
import 'package:restuarant_ui/modal/get_address_from_lat_lng.dart';

class LocationChanger extends StatefulWidget {
  const LocationChanger({super.key, required this.selectedLocation, required this.onLocationSaved});
  final SimpleLocationResult selectedLocation;
  final Function(SimpleLocationResult) onLocationSaved;

  @override
  State<LocationChanger> createState() => _LocationChangerState();
}

class _LocationChangerState extends State<LocationChanger> {
  double zoomLevel = 15.0;
  bool displayOnly = true;
  late SimpleLocationResult newLocation;
  String? _currentAddress;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    newLocation = widget.selectedLocation;
    getAddress(context);
  }

  void getAddress(context) async {
    _currentAddress =
        await getAddressFromLatLng(newLocation.latitude, newLocation.longitude);
    log('$_currentAddress page 0');
    setState(() {});
  }

  Future<void> searchLocation(String searchTerm) async {
    log('Searching for $searchTerm');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: showMap(newLocation),
          ),
          Positioned(
            top: 50.0,
            left: 10.0,
            right: 10.0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                controller: _searchController,
                onSubmitted: (searchTerm) => searchLocation(searchTerm),
                decoration: InputDecoration(
                  hintText: 'Search for location...',
                  border: InputBorder.none,
                  suffixIcon: IconButton(onPressed: (){searchLocation(_searchController.text);}, icon: const Icon(Icons.search)),
                  prefixIcon: IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back)),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Card(
        child: SizedBox(
          height: 100.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _currentAddress ?? 'Location permission not granted!',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Icon(Icons.location_pin),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); 
                  widget.onLocationSaved(newLocation); 
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Save Location'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showMap(selectedLocation) {
    return SizedBox(
      height: double.maxFinite,
      width: double.maxFinite,
      child: FlutterMap(
        options: MapOptions(
          initialCenter: widget.selectedLocation.getLatLng(),
          initialZoom: zoomLevel,
          onTap: (tapLoc, position) {
            if (true) {
              changeLocation(position.latitude, position.longitude);
            }
          },
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          ),
          MarkerLayer(markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: selectedLocation.getLatLng(),
              child: const Icon(
                Icons.location_pin,
                size: 40,
                color: Color.fromARGB(255, 255, 7, 7),
              ),
            ),
          ])
        ],
      ),
    );
  }

  void changeLocation(latitude, longitude) async {
    newLocation = SimpleLocationResult(latitude, longitude);
    _currentAddress = await getAddressFromLatLng(latitude, longitude);
    setState(() {});
  }
}
