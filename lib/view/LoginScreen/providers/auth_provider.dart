import 'package:dio/dio.dart';
import 'package:ems/core/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ems/view/Dashboard/dashboard.dart';

class AuthProvider extends ChangeNotifier {
  bool _obscurePassword = true;
  bool _rememberMe = false;
  bool _isLoading = false;

  bool get obscurePassword => _obscurePassword;
  bool get rememberMe => _rememberMe;
  bool get isLoading => _isLoading;

  final AuthService _authService = AuthService();

  void togglePassword() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleRemember(bool value) {
    _rememberMe = value;
    notifyListeners();
  }

  Future<void> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _authService.login(
        email: email,
        password: password,
      );

      _isLoading = false;
      notifyListeners();

      final data = response.data;

      if (data["status"] == "success") {
        final prefs = await SharedPreferences.getInstance();

        // Save Login Status
        await prefs.setBool("isLoggedIn", true);

        // Save Token
        await prefs.setString("token", data["data"]["token"]);

        // Save User Data
        await prefs.setString("emp_no", data["data"]["user"]["emp_no"] ?? "");

        await prefs.setString(
          "emp_name",
          data["data"]["user"]["emp_name"] ?? "",
        );

        await prefs.setString("email", data["data"]["user"]["email"] ?? "");

        await prefs.setString("role", data["data"]["user"]["role"] ?? "");

        await prefs.setString(
          "emp_type",
          data["data"]["user"]["emp_type"] ?? "",
        );

        await prefs.setString("emp_id", data["data"]["user"]["emp_id"] ?? "");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data["message"]),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Dashboard()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"]), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
    }
  }
}
