import 'package:flutter/material.dart';
import 'package:job_sky/core/firebase_auth_service/Home/get_cards_data.dart';
import 'package:job_sky/models/user_model.dart';

class CardsDataViewModel extends ChangeNotifier {
  final HomeCardsService homeCardsService = HomeCardsService();

  String? errorMessage;

  Stream<List<UserModel>> getUserStream()  {
    try {
      final cardsData = homeCardsService.getHomeCardsData();
      return cardsData;
    } catch (e) {
      errorMessage = e.toString();
      return Stream.empty();
    } finally {
      notifyListeners();
    }
  }
}
