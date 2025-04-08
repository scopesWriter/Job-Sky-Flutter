import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_sky/views/auth/external_functions/uid_functions.dart';

class ChangeProfileService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> changeProfile(bool isPublic, bool isLookingAndKnowJob,
      bool isUnDegree, String location, String jobs) async {
    final userId = await getUid();
    await firestore
        .collection('users')
        .doc(userId)
        .update({
      'isPublic': isPublic,
      'isLookingAndKnowJob': isLookingAndKnowJob,
      'isUnDegree': isUnDegree,
      'location': location,
      'jobs': jobs
    });
    print('✅ Profile Data Changed ');
  }
}