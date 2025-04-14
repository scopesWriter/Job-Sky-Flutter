//Edit Profile Screen
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/firebase_auth_service/Home/get_cards_data.dart';

final profilePicPathProvider = StateProvider<String>((ref) => '');

//Profile Screen
final isPublicProvider = StateProvider<bool>((ref) => false);
final isLookingAndKnowJobProvider = StateProvider<bool>((ref) => false);
final isUnDegreeProvider = StateProvider<bool>((ref) => false);
final locationProvider = StateProvider<TextEditingController>((ref) => TextEditingController());
final jobsProvider = StateProvider<TextEditingController>((ref) => TextEditingController());
final imagePathProvider = StateProvider<String>((ref) => '');
final selectedDistanceProvider = StateProvider<String>((ref) => '10 miles');


//Edit Profile
final editImagePathProvider = StateProvider<String>((ref) => '');
final editUserNameProvider = StateProvider<TextEditingController>((ref) => TextEditingController());
final editEmailProvider = StateProvider<TextEditingController>((ref) => TextEditingController());
final editPhoneNumberProvider = StateProvider<TextEditingController>((ref) => TextEditingController());




//profile provider
final HomeCardsService dataProvider = HomeCardsService();
final dataProfileProvider = FutureProvider.autoDispose((ref) async {
  return dataProvider.getUserData();
});

