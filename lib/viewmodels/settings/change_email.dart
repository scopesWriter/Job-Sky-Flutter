import 'package:flutter/material.dart';
import '../../core/firebase_auth_service/settings/change_email.dart';

class ChangeEmailViewmodel extends ChangeNotifier {
  final ChangeEmailService changeEmailService = ChangeEmailService();

  Future<void> changeEmail({
    required String newEmail,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) async {

    try {
      await changeEmailService.changeEmail(newEmail: newEmail);
    } catch (e) {
      onSuccess();
    } finally {
    }
  }
}