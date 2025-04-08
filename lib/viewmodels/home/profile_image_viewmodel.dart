import 'package:flutter/material.dart';
import 'package:job_sky/core/firebase_auth_service/profile/user_profile_image.dart';
import 'package:job_sky/models/user_model.dart';

class ProfileImageViewModel extends ChangeNotifier {
  final ProfileImage profileImage = ProfileImage();

  bool isLoading = false;
  String? errorMessage;

  Future<void> uploadImage({
    required String imagePath,
    required VoidCallback onFailure,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      await profileImage.compressAndUploadImage(imagePath);
    } catch (e) {
      onFailure();
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<UserModel> getUserData() async {
    try {
      final image = await profileImage.getProfileImageFromFirebase() ;
      return image ;
    } catch (e) {
      errorMessage = e.toString();
      return UserModel(uid: '', email: '', userName: '', phoneNumber: '', profileImage: '');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
