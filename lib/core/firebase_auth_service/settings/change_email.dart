import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:job_sky/views/auth/external_functions/uid_functions.dart';

class ChangeEmailService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> changeEmail({
    required String newEmail,
  }) async {
    final uid = await getUid();
    try {

      _auth.currentUser?.verifyBeforeUpdateEmail(newEmail);
      _firestore.collection('users').doc(uid).update({'email': newEmail});

    } catch (e) {
      print("Error Email did not Changed: $e");
      rethrow;
    }
    return null;
  }
}
