// lib/core/utils/battery_utils.dart
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class BatteryOptimizationUtil {
  static Future<bool> requestIgnoreBatteryOptimizations() async {
    try {
      final status = await Permission.ignoreBatteryOptimizations.status;

      if (status.isGranted) {
        return true;
      }

      final result = await Permission.ignoreBatteryOptimizations.request();
      return result.isGranted;
    } catch (e) {
      print("❌ Battery optimization error: $e");
      return false;
    }
  }

  static Future<void> openBatterySettings(BuildContext context) async {
    try {
      if (Theme.of(context).platform == TargetPlatform.android) {
        await Permission.ignoreBatteryOptimizations.request();
      }
    } catch (e) {
      print("❌ Failed to open battery settings: $e");
    }
  }

  static Future<bool> isBatteryOptimizationEnabled() async {
    try {
      final status = await Permission.ignoreBatteryOptimizations.status;
      return !status.isGranted;
    } catch (e) {
      print("❌ Failed to check battery optimization: $e");
      return true;
    }
  }
}
