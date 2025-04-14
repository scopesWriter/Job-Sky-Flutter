
import 'dart:convert';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodels/home/get_cards_data.dart';

//Bottom Navigation
final bottomIndexProvider = StateProvider<int>((ref) => 0); //index



//Home Screen
final cardIndexProvider = StateProvider<int>((ref) => 0);
final swiperControllerProvider = StateProvider<SwiperController>((ref) => SwiperController());
final decodedImageProvider = StateProvider<Map<String, Image>>((ref) => {});
final cardsProvider = StateProvider<List<Widget>>((ref) {
  return [];
});

final decodedImageFutureProvider =
FutureProvider.family<Image?, String>((ref, uid) async {
  final userDataAsync = ref.watch(cardsDataProvider);

  return userDataAsync.when(
    data: (userData) {
      // Now `userData` is a List<UserModel>
      try {
        final user = userData.firstWhere((user) => user.uid == uid);

        if (user.profileImage != null && user.profileImage!.isNotEmpty) {
          return Image.memory(
            base64Decode(user.profileImage!.split(',').last),
            fit: BoxFit.cover,
          );
        }
      } catch (e) {
        // User not found or profile image is invalid
        return null;
      }
      return null;
    },
    loading: () {
      // Return null while the data is loading
      return null;
    },
    error: (error, stackTrace) {
      // Log the error or handle it as needed
      debugPrint('Error fetching user data: $error');
      return null;
    },
  );
});

//Home Screen
final cardsDataProvider = FutureProvider.autoDispose((ref) async => CardsDataViewModel().getUsersData());