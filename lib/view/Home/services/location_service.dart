import 'package:dio/dio.dart';
import 'package:ems/core/network/api_client.dart';
import 'package:ems/core/network/api_endpoints.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<Placemark> getPlacemarkFromCoordinates(
    double latitude,
    double longitude,
  ) async {
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
      address:
          "${placemark.street}, ${placemark.subLocality}, ${placemark.locality}",
      city: placemark.locality ?? "",
      state: placemark.administrativeArea ?? "",
      pincode: placemark.postalCode ?? "",
    );
  }

  Future<Response> createLocation({
    required double latitude,
    required double longitude,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token") ?? "";

    final response = await ApiClient.dio.post(
      ApiEndpoints.employeeLocationCreate,
      data: FormData.fromMap({
        "latitude": latitude.toString(),
        "longitude": longitude.toString(),
      }),
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
        contentType: "multipart/form-data",
      ),
    );

    if (response.data["status"] == "success") {
      return response;
    }

    throw Exception(response.data["message"]);
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
