import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:job_sky/models/feedback_model.dart';
import 'package:job_sky/views/auth/external_functions/uid_functions.dart';

class FeedbackService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> userFeedback({
    required String feedbackTitle,
    required String feedbackMessage,
  }) async {
    final uid = await getUid();
    final username = _auth.currentUser!.displayName;
    try {

      FeedbackModel feedback = FeedbackModel(
        userName: username!,
        uid: uid!,
        feedbackTitle: feedbackTitle,
        feedbackMessage: feedbackMessage
      );

      await _firestore.collection('feedback').doc(uid).collection('feedbacks').add(feedback.toMap());
      print('✅ Feedback sent successfully.');

    } catch (e) {
      print("   Error Feedback did not sent: $e");
      rethrow;
    }
  }
}
