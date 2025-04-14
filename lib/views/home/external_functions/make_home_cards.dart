import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/external_function/claculate_distance.dart';
import '../../../models/user_model.dart';
import '../../../widgets/home_card.dart';

List<Widget> makeCard(List<UserModel> cardsData) {
  List<Widget> cards = [];

  final uid = FirebaseAuth.instance.currentUser!.uid;

  UserModel? currentUser;
  for (final user in cardsData) {
    if (user.uid == uid) {
      print('User found: ${user.uid} == $uid');
      currentUser = user;
      break;
    }
  }

  if (currentUser == null) {
    return cards;
  }

  for (final user in cardsData) {
    // Skip the current user's card
    if (user.uid == uid) {
      continue;
    }

    // Calculate the distance between the current user and the other user
    final distance = calculateDistance(
      currentUser.lat,
      currentUser.lng,
      user.lat,
      user.lng,
    );

    // Check if the distance is within the allowed range
    if (distance > getDistance(currentUser.distance)) {
      continue;
    }

    // Add the card for the other user
    cards.add(
      Container(
        key: ValueKey(user.uid), // Unique key for each card
        child: HomeCard(
          data: user,
          cardsNumber: cardsData.length - 1, // Exclude the current user
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
      return 50; // Default to 50 miles if the value is unrecognized
  }
}