import 'package:flutter/material.dart';
import 'package:job_sky/core/firebase_auth_service/auth/login.dart';


class LoginViewModel extends ChangeNotifier {
  final LoginService _authService = LoginService();

  bool isLoading = false;
  String? errorMessage;

  Future<void> Login({
    required String email,
    required String password,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,

  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      await _authService.LoginWithEmail(
        email: email,
        password: password,
      );
      onSuccess();

    } catch (e) {
      onFailure();
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}