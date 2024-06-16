// import 'dart:developer';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';

// import 'package:latlong2/latlong.dart';
import 'package:restuarant_ui/modal/location.dart';
import 'package:restuarant_ui/control/get_address_from_lat_lng.dart';

import '../control/get_coordinates_from_search.dart';

class LocationChanger extends StatefulWidget {
  const LocationChanger(
      {super.key,
      required this.selectedLocation,
      required this.onLocationSaved});

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
  Position? _currentPosition;
  late MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    newLocation = widget.selectedLocation;
    _mapController = MapController();
    getAddress(context);
  }

  void getAddress(context) async {
    _currentAddress =
        await getAddressFromLatLng(newLocation.latitude, newLocation.longitude);
    setState(() {});
  }

  Future<void> searchLocation(String searchTerm) async {
    log('Searching for $searchTerm');
    final coordinates = await getCoordinatesFromSearch(searchTerm);
    if (coordinates != null) {
      changeLocation(coordinates['latitude']!, coordinates['longitude']!);
      newLocation = SimpleLocationResult(
          coordinates['latitude']!, coordinates['longitude']!);
      _mapController.move(newLocation.getLatLng(), zoomLevel);
      setState(() {});
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Location not found')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          showMap(newLocation),
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
              child: TypeAheadField(
                controller: _searchController,
                builder: (context, controller, focusNode) => TextField(
                  onSubmitted: (searchTerm){
                    searchLocation(searchTerm);
                  },
                  controller: controller,
                  focusNode: focusNode,
                  // autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Search for location...',
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                        onPressed: () {
                          searchLocation(_searchController.text);
                        },
                        icon: const Icon(Icons.search)),
                    prefixIcon: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back)),
                  ),
                ),
                suggestionsCallback: (pattern) async {
                  return await getAutocompleteSuggestions(pattern);
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion.toString()),
                  );
                },
                onSelected: (suggestion) async {
                  _searchController.text = suggestion.toString();
                  FocusManager.instance.primaryFocus?.unfocus();
                  await searchLocation(suggestion.toString());
                },
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Card(
        child: SizedBox(
          height: 150.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  getCurrentAddress(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.my_location_rounded),
                    Text(
                      'Select current location',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              const Gap(2),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_pin),
                  Text(
                    _currentAddress ?? 'Location permission not granted!',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
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
          initialCenter: selectedLocation.getLatLng(),
          initialZoom: zoomLevel,
          onTap: (tapLoc, position) {
            if (true) {
              changeLocation(position.latitude, position.longitude);
            }
          },
        ),
        mapController: _mapController,
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
    // _mapController.move(newLocation.getLatLng(), zoomLevel);
    setState(() {});
  }

  void getCurrentAddress(context) async {
    _currentPosition = await getCurrentPosition(context);
    _currentAddress = await getAddressFromLatLng(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
    );
    newLocation = SimpleLocationResult(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
    );
    _mapController.move(newLocation.getLatLng(), zoomLevel);
    setState(() {});
  }
}
