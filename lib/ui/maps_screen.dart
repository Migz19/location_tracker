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
  Position? _currentLocation;
  Completer<GoogleMapController> _mapsController = Completer<GoogleMapController>();


  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    _currentLocation = await LocationHelper().getCurrentLocation();
    if (mounted) {
      setState(() {});
    }
  }

  CameraPosition get _initialCameraPosition {
    print("312784237842${_currentLocation!.latitude}");
    return _currentLocation != null
        ? CameraPosition(
      target: LatLng(_currentLocation!.latitude, _currentLocation!.longitude),
      zoom: 17,
    )
        : const CameraPosition(
      target: LatLng(31.324329, 31.2391293),
      zoom: 1,
    );
  }

  Widget buildMap() {
    if (_currentLocation == null) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.amberAccent,
        ),
      );
    } else {
      return GoogleMap(
        mapType: MapType.normal,
        // check the parameters
        myLocationEnabled: true,
        initialCameraPosition: _initialCameraPosition,


        compassEnabled: true,
        zoomControlsEnabled: false,
        myLocationButtonEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          if (!_mapsController.isCompleted) {
            _mapsController.complete(controller);
          }

        },
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildMap(),
        ],
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: navigateToCurrentLocation,
        child: const Icon(
          Icons.place,
          color: Colors.red,
        ),
      ),*/
    );
  }

  Future<void> navigateToCurrentLocation() async {
    if (_currentLocation != null ) {
      final GoogleMapController controller = await _mapsController.future;
      if (mounted) {
        controller.animateCamera(
          CameraUpdate.newCameraPosition(_initialCameraPosition),
        );
      }
    }
  }
  Future<void> _goToMyCurrentLocation() async {
    final GoogleMapController controller = await _mapsController.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(_initialCameraPosition));
  }


}
