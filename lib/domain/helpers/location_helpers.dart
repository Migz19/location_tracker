import 'package:geolocator/geolocator.dart';
class LocationHelper{
  bool isServiceEnabled=false;
  Future<Position>getCurrentLocation()async {

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();
    if (!isServiceEnabled) {

      await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

  }
}