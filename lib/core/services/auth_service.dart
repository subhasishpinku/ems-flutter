import 'package:dio/dio.dart';
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

    return await ApiClient.dio.post(
      ApiEndpoints.login,
      data: formData,
    );
  }
}