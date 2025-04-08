import 'package:flutter/material.dart';
import '../../core/firebase_auth_service/auth/forgot_password.dart';


class ForgotViewModel extends ChangeNotifier {
  final ForgotPasswordService _authService = ForgotPasswordService();

  bool isLoading = false;
  String? errorMessage;

  Future<void> ForgotPassword({
    required String email,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,

  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      await _authService.forgotPassword(
        email: email,
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