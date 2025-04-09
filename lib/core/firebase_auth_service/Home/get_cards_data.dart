import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_sky/models/user_model.dart';

class HomeCardsService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<UserModel>> getHomeCardsData()  {
    try {
      return FirebaseFirestore.instance.collection('users').snapshots().map((snapshot) {
        return snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
      });
    } catch (e) {
      print("Error retrieving data: $e");
      return Stream.empty();
    }
  }
}
