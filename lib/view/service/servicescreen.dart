import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  bool _isTracking = false;

  String latitude = "";
  String longitude = "";
  String address = "";

  @override
  void initState() {
    super.initState();
    _checkServiceStatus();
  }

  Future<void> _checkServiceStatus() async {
    final service = FlutterBackgroundService();

    bool running = await service.isRunning();

    setState(() {
      _isTracking = running;
    });
  }

  Future<bool> _requestPermission() async {
    var status = await Permission.location.request();

    if (!status.isGranted) {
      if (status.isPermanentlyDenied) {
        openAppSettings();
      }
      return false;
    }

    var bgStatus = await Permission.locationAlways.request();

    if (!bgStatus.isGranted) {
      if (bgStatus.isPermanentlyDenied) {
        openAppSettings();
      }
      return false;
    }

    return true;
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      latitude = position.latitude.toString();
      longitude = position.longitude.toString();

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;

        address =
            "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      }

      debugPrint("==============================");
      debugPrint("Latitude : $latitude");
      debugPrint("Longitude: $longitude");
      debugPrint("Address  : $address");
      debugPrint("==============================");

      Fluttertoast.showToast(
        msg:
            "Latitude : $latitude\nLongitude : $longitude\n\n$address",
        toastLength: Toast.LENGTH_LONG,
      );

      setState(() {});
    } catch (e) {
      debugPrint("Location Error : $e");
    }
  }

  Future<void> _startService() async {
    bool granted = await _requestPermission();

    if (!granted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Location Permission Required"),
        ),
      );
      return;
    }

    await _getCurrentLocation();

    final service = FlutterBackgroundService();

    if (!await service.isRunning()) {
      await service.startService();
    }

    setState(() {
      _isTracking = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Background Service Started"),
      ),
    );
  }

  Future<void> _stopService() async {
    final service = FlutterBackgroundService();

    if (await service.isRunning()) {
      service.invoke("stopService");
    }

    setState(() {
      _isTracking = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Background Service Stopped"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Background Location Service"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _isTracking
                  ? Icons.location_on
                  : Icons.location_off,
              color:
                  _isTracking ? Colors.green : Colors.red,
              size: 80,
            ),

            const SizedBox(height: 20),

            Text(
              _isTracking
                  ? "Tracking Started"
                  : "Tracking Stopped",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Text(
                      "Latitude : $latitude",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Longitude : $longitude",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      address.isEmpty
                          ? "Address : Not Available"
                          : address,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _isTracking
                    ? _stopService
                    : _startService,
                child: Text(
                  _isTracking
                      ? "Stop Service"
                      : "Start Service",
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}