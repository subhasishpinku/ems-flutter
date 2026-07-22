import 'dart:async';
import 'package:ems/core/services/attendance_service.dart';
import 'package:ems/core/services/dashboard_service.dart';
import 'package:ems/core/services/profile_service.dart';
import 'package:ems/core/utils/CountdownTimer.dart';
import 'package:ems/view/Home/model/attendance_model.dart';
import 'package:ems/view/Home/model/dashboard_month.dart';
import 'package:ems/view/Home/model/profile_model.dart';
import 'package:ems/view/Home/model/visitSummary_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/location_service.dart';
import '../services/internet_service.dart';

class HomeProvider extends ChangeNotifier {
  final LocationService _locationService = LocationService();
  final InternetService _internetService = InternetService();
  final AttendanceService _attendanceService = AttendanceService();
  final ProfileService _profileService = ProfileService();
  DateTime? punchInTime;
  final DashboardService _dashboardService = DashboardService();

  List<DashboardMonth> months = [];

  DashboardMonth? selectedMonth;
  static const String _punchInTimeKey = "punch_in_time";
  bool isUpdatingProfile = false;
  Timer? _locationTimer;
  Timer? _workTimer;

  bool isPunchIn = false;
  Duration workedDuration = Duration.zero;
  DateTime currentTime = DateTime.now();

  LocationData? locationData;
  bool isLoading = false;
  String? errorMessage;
  ProfileModel? profile;

  AttendanceModel? attendance;
  VisitSummaryModel? visitSummary;
  HomeProvider() {
    _loadPunchStatus();
    _startTimeUpdater();
    _startLocationTimer();

    loadProfile();
    loadMonths();
  }
  Future<void> loadMonths() async {
    months = await _dashboardService.getMonths();

    selectedMonth = months.firstWhere((e) => e.selected);

    await loadAttendance(
      month: selectedMonth!.month,
      year: selectedMonth!.year,
    );

    await loadVisitSummary(
      month: selectedMonth!.month,
      year: selectedMonth!.year,
    );

    notifyListeners();
  }

  Future<void> loadAttendance({required int month, required int year}) async {
    attendance = await _attendanceService.getAttendance(
      month: month,
      year: year,
    );

    notifyListeners();
  }

  Future<void> loadVisitSummary({required int month, required int year}) async {
    visitSummary = await _attendanceService.getVisitSummary(
      month: month,
      year: year,
    );

    notifyListeners();
  }

  Future<void> changeMonth(DashboardMonth month) async {
    selectedMonth = month;

    notifyListeners();

    await loadAttendance(month: month.month, year: month.year);

    await loadVisitSummary(month: month.month, year: month.year);
  }

  Future<void> loadProfile() async {
    try {
      isLoading = true;
      notifyListeners();

      profile = await _profileService.getProfile();
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void _startTimeUpdater() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      currentTime = DateTime.now();
      notifyListeners();
    });
  }

  void _startLocationTimer() {
    // _locationTimer = Timer.periodic(const Duration(seconds: 10), (timer) async {
    //   await fetchLocation();
    // });
    _locationTimer = Timer.periodic(const Duration(minutes: 1), (timer) async {
      print("1 minute timer fired");
      await fetchLocation();
    });
  }

  Future<void> _loadPunchStatus() async {
    final prefs = await SharedPreferences.getInstance();

    isPunchIn = prefs.getBool("isPunchIn") ?? false;

    final savedTime = prefs.getString(_punchInTimeKey);

    if (savedTime != null) {
      punchInTime = DateTime.parse(savedTime);

      workedDuration = DateTime.now().difference(punchInTime!);
    }

    if (isPunchIn) {
      startWorkTimer();
    }

    notifyListeners();
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
    if (_workTimer != null) return;

    _workTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (punchInTime != null) {
        workedDuration = DateTime.now().difference(punchInTime!);
        notifyListeners();
      }
    });
  }

  // void startWorkTimer() {
  //   _workTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //     workedDuration += const Duration(seconds: 1);
  //     notifyListeners();
  //   });
  // }

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

      final status = response.data["status"]?.toString().toLowerCase() ?? "";
      final message = response.data["message"]?.toString() ?? "";

      // =======================
      // Punch In Success
      // =======================
      if (status == "success") {
        final prefs = await SharedPreferences.getInstance();

        await prefs.setBool("isPunchIn", true);
        punchInTime = DateTime.now();

        await prefs.setString(_punchInTimeKey, punchInTime!.toIso8601String());
        final service = FlutterBackgroundService();

        if (!await service.isRunning()) {
          final countdown = CountdownTimer();
          Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          );
          await LocationService().createLocation(
            latitude: position.latitude,
            longitude: position.longitude,
          );
          countdown.start(() async {
            print("Location sent after 30 minutes");
          });
          await service.startService();
        }

        isPunchIn = true;
        workedDuration = Duration.zero;

        if (_workTimer == null) {
          startWorkTimer();
        }

        notifyListeners();
        return;
      }

      // =======================
      // Already Punch In
      // =======================
      if (status == "error" &&
          message.toLowerCase().contains("already punched in")) {
        final prefs = await SharedPreferences.getInstance();

        await prefs.setBool("isPunchIn", true);
        if (prefs.getString(_punchInTimeKey) == null) {
          punchInTime = DateTime.now();

          await prefs.setString(
            _punchInTimeKey,
            punchInTime!.toIso8601String(),
          );
        } else {
          punchInTime = DateTime.parse(prefs.getString(_punchInTimeKey)!);
        }
        final service = FlutterBackgroundService();

        if (!await service.isRunning()) {
          final countdown = CountdownTimer();
          Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          );
          await LocationService().createLocation(
            latitude: position.latitude,
            longitude: position.longitude,
          );

          countdown.start(() async {
            print("Location sent after 30 minutes");
          });
          await service.startService();
        }

        isPunchIn = true;

        if (_workTimer == null) {
          startWorkTimer();
        }

        notifyListeners();
        return;
      }
      // if (status == "error" &&
      //     message.toLowerCase().contains("already punched in")) {
      //   final prefs = await SharedPreferences.getInstance();

      //   await prefs.setBool("isPunchIn", true);

      //   final service = FlutterBackgroundService();

      //   if (!await service.isRunning()) {
      //     await service.startService();
      //   }

      //   isPunchIn = true;

      //   if (_workTimer == null) {
      //     startWorkTimer();
      //   }

      //   notifyListeners();

      //   return;
      // }

      // =======================
      // Other Error
      // =======================
      throw Exception(message);
    } catch (e) {
      print("PunchIn Error: $e");
      rethrow;
    }
  }

  // Future<void> punchIn() async {
  //   try {
  //     if (!await checkInternet()) {
  //       throw Exception("No Internet Connection");
  //     }

  //     await fetchLocation();

  //     if (locationData == null) {
  //       throw Exception("Location data not available");
  //     }

  //     final response = await _attendanceService.punchIn(
  //       latitude: locationData!.latitude,
  //       longitude: locationData!.longitude,
  //     );

  //     // Response চেক করুন
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final status = response.data["status"]?.toString().toLowerCase() ?? "";
  //       final message = response.data["message"]?.toString() ?? "";

  //       if (status == "success") {
  //         final prefs = await SharedPreferences.getInstance();

  //         await prefs.setBool("isPunchIn", true);

  //         final service = FlutterBackgroundService();

  //         if (!await service.isRunning()) {
  //           await service.startService();
  //         }

  //         isPunchIn = true;
  //         workedDuration = Duration.zero;

  //         startWorkTimer();

  //         notifyListeners();
  //         return;
  //       }

  //       // Server বলছে Already punched in
  //       if (status == "error" &&
  //           message.toLowerCase().contains("already punched in")) {
  //         final prefs = await SharedPreferences.getInstance();

  //         await prefs.setBool("isPunchIn", true);

  //         final service = FlutterBackgroundService();

  //         if (!await service.isRunning()) {
  //           await service.startService();
  //         }

  //         isPunchIn = true;

  //         if (_workTimer == null) {
  //           startWorkTimer();
  //         }

  //         notifyListeners();
  //         return;
  //       }

  //       throw Exception(message);
  //     } else {
  //       throw Exception("Server error: ${response.statusCode}");
  //     }
  //     // if (response.statusCode == 200 || response.statusCode == 201) {
  //     //   if (response.data["status"] == "success") {
  //     //     final prefs = await SharedPreferences.getInstance();

  //     //     await prefs.setBool("isPunchIn", true);

  //     //     final service = FlutterBackgroundService();

  //     //     if (!await service.isRunning()) {
  //     //       await service.startService();
  //     //     }

  //     //     isPunchIn = true;

  //     //     workedDuration = Duration.zero;

  //     //     startWorkTimer();

  //     //     notifyListeners();
  //     //   } else {
  //     //     throw Exception(response.data["message"] ?? "Punch In failed");
  //     //   }
  //     // } else {
  //     //   throw Exception("Server error: ${response.statusCode}");
  //     // }
  //   } catch (e) {
  //     print("PunchIn Error: $e");
  //     rethrow;
  //   }
  // }

  Future<void> punchOut() async {
    await fetchLocation();

    final response = await _attendanceService.punchOut(
      latitude: locationData!.latitude,
      longitude: locationData!.longitude,
    );

    if (response.data["status"] == "success") {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setBool("isPunchIn", false);
      await prefs.remove(_punchInTimeKey);

      punchInTime = null;
      workedDuration = Duration.zero;
      stopWorkTimer();

      final service = FlutterBackgroundService();

      service.invoke("stopService");

      isPunchIn = false;
      final countdown = CountdownTimer();
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      await LocationService().createLocation(
        latitude: position.latitude,
        longitude: position.longitude,
      );
      await countdown.stop(() async {
        print("Location sent");
      });

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

  Future<void> updateProfile({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String dob,
    required String joining,
    required String address,
    String? imagePath,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      await _profileService.updateProfile(
        name: name,
        email: email,
        phone: phone,
        password: password,
        dob: dob,
        joiningDate: joining, // <-- এখানে joiningDate ব্যবহার করতে হবে
        address: address,
        imagePath: imagePath,
      );

      // Update হওয়ার পর নতুন profile load হবে
      profile = await _profileService.getProfile();
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  // Future<void> updateProfile({
  //   required String name,
  //   required String email,
  //   required String phone,
  //   required String password,
  //   required String dob,
  //   required String joining,
  //   required String address,
  //   String? imagePath,
  // }) async {
  //   try {
  //     isUpdatingProfile = true;
  //     notifyListeners();

  //     final response = await _profileService.updateProfile(
  //       name: name,
  //       email: email,
  //       phone: phone,
  //       password: password,
  //       dob: dob,
  //       joiningDate: joining,
  //       address: address,
  //       imagePath: imagePath,
  //     );

  //     profile = ProfileModel.fromJson(response.data["data"]["profile"]);
  //   } finally {
  //     isUpdatingProfile = false;
  //     notifyListeners();
  //   }
  // }

  @override
  void dispose() {
    _locationTimer?.cancel();
    _workTimer?.cancel();
    super.dispose();
  }
}
