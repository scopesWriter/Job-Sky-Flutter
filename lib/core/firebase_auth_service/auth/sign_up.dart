import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_sky/models/user_model.dart';

import '../../../views/auth/external_functions/uid_functions.dart';

class SignUpService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signUpWithEmail({
    required String email,
    required String password,
    required String username,
    required String phone,

  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;

      if (user != null) {
        UserModel appUser = UserModel(
          uid: user.uid,
          email: email,
          userName: username,
          phoneNumber: phone,
          profileImage: '',
          isPublic: false,
          isLookingAndKnowJob: false,
          isUnDegree: false,
        );

        await _firestore.collection('users').doc(user.uid).set(appUser.toMap());
        await user.updateDisplayName(username);
        await saveUidLocally(user.uid);
        return user;
      }
    } catch (e) {
      print("Sign up error: $e");
      rethrow;
    }
    return null;
  }
}
