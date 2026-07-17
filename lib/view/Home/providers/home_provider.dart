import 'dart:async';
import 'package:ems/core/services/attendance_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import '../services/location_service.dart';
import '../services/internet_service.dart';

class HomeProvider extends ChangeNotifier {
  final LocationService _locationService = LocationService();
  final InternetService _internetService = InternetService();
  final AttendanceService _attendanceService = AttendanceService();
  Timer? _locationTimer;
  Timer? _workTimer;

  bool isPunchIn = false;
  Duration workedDuration = Duration.zero;
  DateTime currentTime = DateTime.now();

  LocationData? locationData;
  bool isLoading = false;
  String? errorMessage;

  HomeProvider() {
    _startTimeUpdater();
    _startLocationTimer();
  }

  void _startTimeUpdater() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      currentTime = DateTime.now();
      notifyListeners();
    });
  }

  void _startLocationTimer() {
    _locationTimer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      await fetchLocation();
    });
  }

  Future<void> fetchLocation() async {
    if (isLoading) return;

    try {
      isLoading = true;
      errorMessage = null;
      locationData = await _locationService.getFullLocationData();
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      print("Location fetch error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> checkInternet() async {
    return await _internetService.hasInternet();
  }

  void startWorkTimer() {
    _workTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      workedDuration += const Duration(seconds: 1);
      notifyListeners();
    });
  }

  void stopWorkTimer() {
    _workTimer?.cancel();
    _workTimer = null;
  }

  Future<void> punchIn() async {
    try {
      if (!await checkInternet()) {
        throw Exception("No Internet Connection");
      }

      await fetchLocation();

      if (locationData == null) {
        throw Exception("Location data not available");
      }

      final response = await _attendanceService.punchIn(
        latitude: locationData!.latitude,
        longitude: locationData!.longitude,
      );

      // Response চেক করুন
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data["status"] == "success") {
          final service = FlutterBackgroundService();
          if (!await service.isRunning()) {
            await service.startService();
          }

          isPunchIn = true;
          workedDuration = Duration.zero;
          startWorkTimer();
          notifyListeners();
        } else {
          throw Exception(response.data["message"] ?? "Punch In failed");
        }
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }
    } catch (e) {
      print("PunchIn Error: $e");
      rethrow;
    }
  }

  Future<void> punchOut() async {
    await fetchLocation();

    final response = await _attendanceService.punchOut(
      latitude: locationData!.latitude,
      longitude: locationData!.longitude,
    );

    if (response.data["status"] == "success") {
      stopWorkTimer();

      final service = FlutterBackgroundService();

      service.invoke("stopService");

      isPunchIn = false;

      notifyListeners();
    } else {
      throw Exception(response.data["message"]);
    }
  }

  String get formattedTime {
    return "${workedDuration.inHours.toString().padLeft(2, '0')}:"
        "${(workedDuration.inMinutes % 60).toString().padLeft(2, '0')}:"
        "${(workedDuration.inSeconds % 60).toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    _locationTimer?.cancel();
    _workTimer?.cancel();
    super.dispose();
  }
}
