import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_sky/models/user_model.dart';

import '../../../views/auth/external_functions/uid_functions.dart';

class HomeCardsService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<UserModel>> getHomeCardsData() async {
    try {
      return await FirebaseFirestore.instance
          .collection('users')
          .get()
          .then(
            (snapshot) =>
                snapshot.docs
                    .map((doc) => UserModel.fromMap(doc.data()))
                    .toList(),
          );
    } catch (e) {
      print("Error retrieving data: $e");
      return [];
    }
  }

  Future<UserModel> getUserData() async {
    try {
      final uid = await getUid();

      return FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get()
          .then((doc) => UserModel.fromMap(doc.data()!));
    } catch (e) {
      print("Error retrieving data: $e");
      return UserModel(
        uid: '',
        email: '',
        userName: '',
        phoneNumber: '',
        profileImage: '',
      );
    }
  }
}
