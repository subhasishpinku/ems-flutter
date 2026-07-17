import 'package:dio/dio.dart';
import 'package:ems/core/network/api_client.dart';
import 'package:ems/core/network/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AttendanceService {
  Future<Response> punchIn({
    required String latitude,
    required String longitude,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      
      print("Token: $token"); // Token check করুন
      print("Latitude: $latitude");
      print("Longitude: $longitude");

      // JSON format এ ডাটা পাঠান
      final response = await ApiClient.dio.post(
        ApiEndpoints.punchIn,
        data: {
          "latitude": latitude,
          "longitude": longitude,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );
      
      print("Response Status: ${response.statusCode}");
      print("Response Data: ${response.data}");
      return response;
      
    } on DioException catch (e) {
      print("DioException Status: ${e.response?.statusCode}");
      print("DioException Data: ${e.response?.data}");
      print("DioException Message: ${e.message}");
      print("DioException Type: ${e.type}");
      
      // Error rethrow করুন
      throw Exception(e.response?.data?['message'] ?? e.message);
      
    } catch (e) {
      print("Unknown Error: $e");
      throw Exception("Something went wrong: $e");
    }
  }

  Future<Response> punchOut({
    required String latitude,
    required String longitude,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      
      final response = await ApiClient.dio.post(
        ApiEndpoints.punchOut,
        data: {
          "latitude": latitude,
          "longitude": longitude,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );
      
      return response;
      
    } on DioException catch (e) {
      print("PunchOut Error: ${e.response?.data}");
      throw Exception(e.response?.data?['message'] ?? e.message);
    }
  }
}