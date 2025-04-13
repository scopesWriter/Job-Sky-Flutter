import 'package:flutter/material.dart';
import '../../core/firebase_auth_service/auth/logout.dart';


class LogoutViewModel extends ChangeNotifier {
  final LogoutService _authService = LogoutService();

  bool isLoading = false;
  String? errorMessage;

  Future<void> logout() async {
    try {
      await _authService.logout();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


}