import 'package:firebase_auth/firebase_auth.dart';

class ChangeEmailService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> changeEmail({
    required String newEmail,
  }) async {
    final user = _auth.currentUser;
    try {
      await user!.verifyBeforeUpdateEmail(newEmail);

    } catch (e) {
      print("Error Email did not Changed: $e");
      rethrow;
    }
    return null;
  }
}
