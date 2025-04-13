import 'package:firebase_auth/firebase_auth.dart';

class LogoutService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Sign up error: $e");
      rethrow;
    }
    return null;
  }
}
