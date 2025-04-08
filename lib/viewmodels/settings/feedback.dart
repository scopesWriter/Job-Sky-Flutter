import 'package:flutter/material.dart';
import '../../core/firebase_auth_service/settings/feedback.dart';

class UserFeedbackViewmodel extends ChangeNotifier {
  final FeedbackService feedbackService = FeedbackService();

  Future<void> userFeedback({
    required String feedbackTitle,
    required String feedbackMessage,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) async {

    try {
      await feedbackService.userFeedback(feedbackTitle: feedbackTitle, feedbackMessage: feedbackMessage) ;
      onSuccess();
    } catch (e) {
      onFailure();
    }
  }
}