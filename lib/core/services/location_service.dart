import 'package:dio/dio.dart';
import 'package:ems/core/network/api_client.dart';
import 'package:ems/core/network/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationService {
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
