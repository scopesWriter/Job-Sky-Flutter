import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> forgotPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } catch (e) {
      print("Forgot password error: $e");
      rethrow;
    }
  }
}
