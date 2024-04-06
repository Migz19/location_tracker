import 'package:geolocator/geolocator.dart';
class LocationHelper{
  bool isServiceEnabled=false;
  Future<Position>getCurrentLocation()async {
    print("4203903249023");
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();
    if (!isServiceEnabled) {
      print("4203903249023");
      await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

  }
}