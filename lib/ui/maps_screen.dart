import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_tracker/core/app_assets.dart';
import 'package:location_tracker/domain/helpers/location_helpers.dart';
import 'package:location_tracker/ui/widgets/custom_drawer.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  Position? _currentLocation;
  Completer<GoogleMapController> _mapsController =
      Completer<GoogleMapController>();
  FloatingSearchBarController searchBarController =
      FloatingSearchBarController();

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

  CameraPosition get _currentCameraPosition {
    return _currentLocation != null
        ? CameraPosition(
            target:
                LatLng(_currentLocation!.latitude, _currentLocation!.longitude),
            zoom: 17,
          )
        : const CameraPosition(
            target: LatLng(0, 0),
            zoom: 1,
          );
  }

  Widget buildMap() {
    return GoogleMap(
        mapType: MapType.normal,
        // check the parameters
        myLocationEnabled: true,
        initialCameraPosition: _currentCameraPosition,
        compassEnabled: true,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          if (!_mapsController.isCompleted) {
            _mapsController.complete(controller);
          }
        });
  }

  Widget buildFloatingSearchBar() {
    final isPortraitMode =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return FloatingSearchBar(
        controller: searchBarController,
        elevation: 6,
        hint: "Search",
        hintStyle: TextStyle(color: Colors.red, fontSize: 15),
        queryStyle: TextStyle(fontSize: 18),
        border: BorderSide(style: BorderStyle.none),
        margins: EdgeInsets.fromLTRB(20, 70, 20, 0),
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
        iconColor: Colors.red,
        scrollPadding: EdgeInsets.only(top: 16, bottom: 50),
        transitionDuration: Duration(milliseconds: 300),
        transitionCurve: Curves.easeInOut,
        physics: BouncingScrollPhysics(),
        axisAlignment: isPortraitMode ? 0 : -1,
        width: isPortraitMode ? 600 : 500,
        debounceDelay: Duration(milliseconds: 500),
        onQueryChanged: (query) {
          //when typing starts
        },
        onFocusChanged: (_) {},
        transition: CircularFloatingSearchBarTransition(),
        actions: [
          FloatingSearchBarAction(
              showIfOpened: false,
              child:
                  CircularButton(icon: Icon(Icons.search), onPressed: () {})),
        ],
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(
          drawerHeaderColor: Colors.red,
          drawerImagePath: AppAssets.drawerImage),
      body: Stack(
        fit: StackFit.expand,
        children: [
          _currentLocation == null
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                )
              : buildMap(),
          buildFloatingSearchBar(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        highlightElevation: 20,
        onPressed: navigateToCurrentLocation,
        child: const Icon(
          Icons.place,
          color: Colors.red,
        ),
      ),
    );
  }

  Future<void> navigateToCurrentLocation() async {
    if (_currentLocation != null) {
      final GoogleMapController controller = await _mapsController.future;
      if (mounted) {
        controller.animateCamera(
          CameraUpdate.newCameraPosition(_currentCameraPosition),
        );
      }
    }
  }
// void launchMapsUrl(sourceLatitude, sourceLongitude, destinationLatitude,
//     destinationLongitude) async {
//   final url = 'https://www.google.com/maps/dir/?api=1&origin=32.321874382,$sourceLongitude&destination=$destinationLatitude,$destinationLongitude';
//   if (await canLaunchUrl(Uri.parse(url))) {
//     await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication);
//   } else {
//     throw 'Could not launch $url';
//   }
// }
}
