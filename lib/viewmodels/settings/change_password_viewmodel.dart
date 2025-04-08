import 'package:flutter/material.dart';
import 'package:job_sky/core/firebase_auth_service/settings/change_password.dart';

class ChangePasswordViewmodel extends ChangeNotifier {
  final ChangePasswordService changePasswordService = ChangePasswordService();

  Future<void> changePassword({
    required String newPassword,
    required String oldPassword,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) async {

    try {
      await changePasswordService.changePassword(
          oldPassword: oldPassword,
          newPassword: newPassword
      );
    } catch (e) {
      onSuccess();
    } finally {
    }
  }
}