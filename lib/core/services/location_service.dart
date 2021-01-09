import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class LocationService {
  Future<void> requestLocationAccess() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {}
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {}
    }
  }

  Future<Position> getLocation() async {
    try {
      Location location = new Location();
      final locationData = await location.getLocation();
      return Position(longitude: locationData.longitude, latitude: locationData.latitude);
    } catch (e) {
      ///return coordinate of Hurstville if any error occurs.
      return Position(longitude: 151.1010, latitude: -33.9646);
    }
  }
}
