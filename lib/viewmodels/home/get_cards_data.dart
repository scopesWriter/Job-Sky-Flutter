import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_sky/core/firebase_auth_service/Home/get_cards_data.dart';
import 'package:job_sky/models/user_model.dart';

class CardsDataViewModel extends ChangeNotifier {
  final HomeCardsService homeCardsService = HomeCardsService();

  String? errorMessage;

  Future<List<UserModel>> getUsersData() async {
    try {
      final cardsData = homeCardsService.getHomeCardsData();
      return cardsData;
    } catch (e) {
      errorMessage = e.toString();
      return [];
    } finally {
      notifyListeners();
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    final snapshot = await FirebaseFirestore.instance.collection('users').get();
    return snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
  }

}
