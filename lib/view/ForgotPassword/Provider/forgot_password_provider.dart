import 'package:flutter/material.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> sendResetLink(String email) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;
    notifyListeners();
  }
}