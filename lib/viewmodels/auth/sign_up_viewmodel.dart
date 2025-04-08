import 'package:flutter/material.dart';
import '../../core/firebase_auth_service/auth/sign_up.dart';

class SignUpViewModel extends ChangeNotifier {
  final SignUpService _authService = SignUpService();

  bool isLoading = false;
  String? errorMessage;

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
    required String phone,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,

  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      await _authService.signUpWithEmail(
        email: email,
        password: password,
        username: username,
        phone: phone,
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
