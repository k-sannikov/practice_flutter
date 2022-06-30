import 'package:geolocator/geolocator.dart';

class Location {
  static Future<Position> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Службы определения местоположения отключены.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('В разрешениях на местоположение отказано');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Разрешения на местоположение постоянно запрещены, мы не можем запрашивать разрешения.');
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

}