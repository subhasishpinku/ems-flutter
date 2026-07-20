import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';

class AuthService {
  Future<Response> login({
    required String email,
    required String password,
  }) async {
    FormData formData = FormData.fromMap({
      "email": email,
      "password": password,
    });

    return await ApiClient.dio.post(ApiEndpoints.login, data: formData);
  }

  Future<Response> logout() async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString("token") ?? "";
    print("token $token");
    return await ApiClient.dio.post(
      ApiEndpoints.logout,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      ),
    );
  }

  Future<Response> refreshToken() async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString("token") ?? "";

    return await ApiClient.dio.post(
      ApiEndpoints.refreshToken, // /api/auth/refresh.php
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      ),
    );
  }
}
