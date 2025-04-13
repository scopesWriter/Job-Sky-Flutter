import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_sky/views/auth/external_functions/uid_functions.dart';

class FriendsListService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addFriend(String friendId) async {
    final userId = await getUid();

    await firestore.collection('users').doc(friendId).update({'followers': FieldValue.arrayUnion([userId])});
    await firestore.collection('users').doc(userId).update({'following': FieldValue.arrayUnion([friendId])});

    print('✅ Profile Data Changed ');
  }

  Future<void> deleteFriend(String friendId) async {
    final userId = await getUid();

    await firestore.collection('users').doc(friendId).update({'followers': FieldValue.arrayRemove([userId])});
    await firestore.collection('users').doc(userId).update({'following': FieldValue.arrayRemove([friendId])});

    print('✅ Profile Data Changed ');
  }
}
