import 'package:ems/view/Home/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void showLocationDialog(
  BuildContext context,
  HomeProvider provider,
  String title,
) async {
  // Initialize notification plugin
  final FlutterLocalNotificationsPlugin notifications =
      FlutterLocalNotificationsPlugin();

  try {
    // Show notification with custom sound
    await notifications.show(
      id: DateTime.now().millisecond,
      title: title,
      body: "Location captured successfully",
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          'location_tracking_v2',
          'Location Tracking',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          enableVibration: true,
          // Use custom sound without extension
          sound: RawResourceAndroidNotificationSound('notification_sound'),
          styleInformation: BigTextStyleInformation(
            "Latitude: ${provider.locationData?.latitude ?? 'N/A'}\n"
            "Longitude: ${provider.locationData?.longitude ?? 'N/A'}\n"
            "Address: ${provider.locationData?.address ?? 'N/A'}\n"
            "City: ${provider.locationData?.city ?? 'N/A'}\n"
            "State: ${provider.locationData?.state ?? 'N/A'}\n"
            "Pincode: ${provider.locationData?.pincode ?? 'N/A'}"
          ),
        ),
      ),
    );
  } catch (e) {
    print("Notification error: $e");
    // Fallback to default sound
    try {
      await notifications.show(
        id: DateTime.now().millisecond,
        title: title,
        body: "Location captured successfully",
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            'location_tracking_v2',
            'Location Tracking',
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            enableVibration: true,
            styleInformation: BigTextStyleInformation(
              "Latitude: ${provider.locationData?.latitude ?? 'N/A'}\n"
              "Longitude: ${provider.locationData?.longitude ?? 'N/A'}\n"
              "Address: ${provider.locationData?.address ?? 'N/A'}"
            ),
          ),
        ),
      );
    } catch (e) {
      print("Fallback notification error: $e");
    }
  }

  // Show dialog
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return AlertDialog(
        title: Row(
          children: [
            Icon(
              provider.isPunchIn ? Icons.check_circle : Icons.logout,
              color: provider.isPunchIn ? Colors.green : Colors.red,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        content: provider.isLoading
            ? const SizedBox(
                height: 100,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 10),
                      Text("Fetching location..."),
                    ],
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (provider.locationData != null) ...[
                      _buildDetailRow(
                        icon: Icons.location_on,
                        label: "Latitude",
                        value: provider.locationData!.latitude,
                      ),
                      _buildDetailRow(
                        icon: Icons.location_on,
                        label: "Longitude",
                        value: provider.locationData!.longitude,
                      ),
                      const Divider(),
                      _buildDetailRow(
                        icon: Icons.home,
                        label: "Address",
                        value: provider.locationData!.address,
                      ),
                      _buildDetailRow(
                        icon: Icons.location_city,
                        label: "City",
                        value: provider.locationData!.city,
                      ),
                      _buildDetailRow(
                        icon: Icons.map,
                        label: "State",
                        value: provider.locationData!.state,
                      ),
                      _buildDetailRow(
                        icon: Icons.pin_drop,
                        label: "Pincode",
                        value: provider.locationData!.pincode,
                      ),
                    ],
                    if (provider.errorMessage != null)
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red.shade200),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.error, color: Colors.red.shade700),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                provider.errorMessage!,
                                style: TextStyle(
                                  color: Colors.red.shade700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("CANCEL"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: provider.isPunchIn ? Colors.green : Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}

Widget _buildDetailRow({
  required IconData icon,
  required String label,
  required String value,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: Colors.grey.shade600),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value.isEmpty ? "N/A" : value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}