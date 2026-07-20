import 'package:ems/view/Home/services/location_service.dart';
import 'package:flutter/material.dart';

class LocationProvider extends ChangeNotifier {
  final LocationService _service = LocationService();

  bool isLoading = false;

  Future<void> sendLocation({
    required double latitude,
    required double longitude,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      await _service.createLocation(latitude: latitude, longitude: longitude);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
