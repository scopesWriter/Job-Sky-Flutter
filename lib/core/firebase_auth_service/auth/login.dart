import 'package:firebase_auth/firebase_auth.dart';

import '../../../views/auth/external_functions/uid_functions.dart';

class LoginService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> LoginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (user.user != null) {
        await saveUidLocally(user.user!.uid);
        return user.user;
      }

    } catch (e) {
      print("Sign up error: $e");
      rethrow;
    }
    return null;
  }
}
