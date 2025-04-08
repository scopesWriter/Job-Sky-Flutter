import 'package:firebase_auth/firebase_auth.dart';

class ChangePasswordService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
        email: _auth.currentUser!.email!,
        password: oldPassword,
      );
      if (user.user != null) {
        await  user.user!.updatePassword(newPassword);
        return user.user;
      }

    } catch (e) {
      print("Sign up error: $e");
      rethrow;
    }
    return null;
  }
}
