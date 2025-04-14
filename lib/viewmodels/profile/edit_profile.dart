import 'package:flutter/material.dart';
import '../../core/firebase_auth_service/profile/edit_profile_screen.dart';

class EditProfileViewModel extends ChangeNotifier {
  final EditProfileScreenService editProfileService = EditProfileScreenService();

  Future<void> changeProfile({
    required String username,
    required String phone,
    required String email,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) async {
    // notifyListeners();

    try {
      await editProfileService.editProfile(username, phone, email);
      onSuccess();
    } catch (e) {
      onFailure();
    } finally {}
  }
}
