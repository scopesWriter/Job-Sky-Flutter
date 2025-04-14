import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/external_function/claculate_distance.dart';
import '../../../models/user_model.dart';
import '../../../widgets/home_card.dart';


List<Widget> makeCard(List<UserModel> cardsData) {
  List<Widget> cards = [];

  UserModel currentUser = cardsData[0];
  final uid = FirebaseAuth.instance.currentUser!.uid;

  for (int i = 1; i < cardsData.length; i++) {
    if (cardsData[i].uid == uid) {
      currentUser = cardsData[i];
      continue;
    }

    final distance = calculateDistance(
      currentUser.lat,
      currentUser.lng,
      cardsData[i].lat,
      cardsData[i].lng,
    );

    if (distance > getDistance(cardsData[0].distance)) {
      continue;
    }

    cards.add(
      Container(
        key: ValueKey(cardsData[i].uid), // Unique key for each card
        child: HomeCard(
          data: cardsData[i],
          cardsNumber: cardsData.length,
        ),
      ),
    );
  }
  return cards;
}
int getDistance(String distance) {
  switch (distance) {
    case '10 miles':
      return 10;
    case '20 miles':
      return 20;
    case '30 miles':
      return 30;
    case '50 miles':
      return 50;
    default:
      return 50;
  }
}