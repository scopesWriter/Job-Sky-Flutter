import 'package:flutter/material.dart';
import 'package:job_sky/core/firebase_auth_service/profile/change_profile.dart';

class ChangeProfileViewModel extends ChangeNotifier {
  final ChangeProfileService changeProfileFirebase = ChangeProfileService();

  Future<void> changeProfile({
    required bool isPublic,
    required bool isLookingAndKnowJob,
    required bool isUnDegree,
    required String location,
    required String jobs,
    required String distance,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) async {
    // notifyListeners();

    try {
      await changeProfileFirebase.changeProfile(
        isPublic,
        isLookingAndKnowJob,
        isUnDegree,
        location,
        jobs,
        distance,
      );
      onSuccess();
    } catch (e) {
      onFailure();
    } finally {}
  }
}
