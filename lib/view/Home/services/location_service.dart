import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permission denied forever');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<Placemark> getPlacemarkFromCoordinates(double latitude, double longitude) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      latitude,
      longitude,
    );
    if (placemarks.isNotEmpty) {
      return placemarks.first;
    }
    throw Exception('Could not get address');
  }

  Future<LocationData> getFullLocationData() async {
    final position = await getCurrentLocation();
    final placemark = await getPlacemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    return LocationData(
      latitude: position.latitude.toString(),
      longitude: position.longitude.toString(),
      address: "${placemark.street}, ${placemark.subLocality}, ${placemark.locality}",
      city: placemark.locality ?? "",
      state: placemark.administrativeArea ?? "",
      pincode: placemark.postalCode ?? "",
    );
  }
}

class LocationData {
  final String latitude;
  final String longitude;
  final String address;
  final String city;
  final String state;
  final String pincode;

  LocationData({
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.city,
    required this.state,
    required this.pincode,
  });
}