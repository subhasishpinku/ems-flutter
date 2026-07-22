// lib/core/utils/service_utils.dart
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceUtils {
  static Future<bool> isServiceRunning() async {
    try {
      final service = FlutterBackgroundService();
      return await service.isRunning();
    } catch (e) {
      print("❌ Failed to check service status: $e");
      return false;
    }
  }

  static Future<void> startServiceIfNeeded() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      bool isPunchIn = prefs.getBool("isPunchIn") ?? false;

      if (!isPunchIn) {
        print("ℹ️ User not punched in, skipping service start");
        return;
      }

      final service = FlutterBackgroundService();

      if (!await service.isRunning()) {
        print("🚀 Starting background service...");
        await service.startService();
      } else {
        print("✅ Service is already running");
      }
    } catch (e) {
      print("❌ Failed to start service: $e");
    }
  }

  static Future<void> stopService() async {
    try {
      final service = FlutterBackgroundService();

      if (await service.isRunning()) {
        print("🛑 Stopping background service...");
        service.invoke("stopService");
      }
    } catch (e) {
      print("❌ Failed to stop service: $e");
    }
  }

  static Future<void> forceLocationUpdate() async {
    try {
      final service = FlutterBackgroundService();

      if (await service.isRunning()) {
        print("📍 Forcing location update...");
        service.invoke("forceUpdate", {});
      }
    } catch (e) {
      print("❌ Failed to force location update: $e");
    }
  }
}
