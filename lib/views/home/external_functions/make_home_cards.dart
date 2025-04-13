import 'package:flutter/cupertino.dart';

import '../../../core/external_function/claculate_distance.dart';
import '../../../models/user_model.dart';
import '../../../widgets/home_card.dart';
import '../home_screen.dart';

List<Container> makeCard(List<UserModel> cardsData)  {
  List<Container> cards = [];

  for (int i = 0; i < cardsData.length; i++) {
    if (cardsData[i].uid == cardsData[0].uid) {
      continue;
    }
    final distance = calculateDistance(
      cardsData[0].lat,
      cardsData[0].lng,
      cardsData[i].lat,
      cardsData[i].lng,
    );
    if (distance > getDistance(cardsData[0].distance) ) {
      print('=================================');
      print('distance is : $distance');
      continue;
    }
    cards.add(
      Container(
        child: HomeCart(data: cardsData[i], cardsNumber: cardsData.length),
      ),
    );
  }
  return cards;
}