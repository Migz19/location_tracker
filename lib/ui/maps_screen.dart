import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_tracker/domain/helpers/location_helpers.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  static Position? _currentLocation;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();

  }

  Completer<GoogleMapController> _mapsController = Completer<GoogleMapController>();

  Future<void> getCurrentLocation() async {
    _currentLocation = await LocationHelper().getCurrentLocation().whenComplete(() { setState(() {

    });});
  }

  static CameraPosition? _cameraPosition;

  Widget buildMap() {
    print("3249892348 ${_currentLocation!.longitude}");
    _cameraPosition = CameraPosition(
        target: LatLng(_currentLocation!.latitude, _currentLocation!.longitude),
        bearing: 0,
        tilt: 0,
        zoom: 17);
    return GoogleMap(
      mapType: MapType.normal,
      myLocationEnabled: true,
      initialCameraPosition: _cameraPosition!,
      compassEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        _mapsController.complete(controller);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _currentLocation == null
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.amberAccent,
                  ),
                )
              : buildMap(),
        ],
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 5.0, top: 5.0, left: 3.0, right: 2.0),
        child: FloatingActionButton(
          onPressed: navigateToCurrentLocation,
          child: Icon(
            Icons.place,
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  Future<void> navigateToCurrentLocation() async {
    final GoogleMapController controller = await _mapsController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition!));
  }
}
