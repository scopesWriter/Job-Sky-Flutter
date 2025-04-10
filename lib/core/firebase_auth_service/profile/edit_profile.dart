import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_sky/views/auth/external_functions/uid_functions.dart';

class EditProfileService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> editProfile(String username, String phone, String email) async {
    final userId = await getUid();
    await firestore
        .collection('users')
        .doc(userId)
        .update({
      'username': username,
      'phone': phone,
    });
    print('✅ Profile Data updated ');
  }
}