
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Bottom Navigation
final bottomIndexProvider = StateProvider<int>((ref) => 0); //index


//Profile Screen
final isPublicProvider = StateProvider<bool>((ref) => false);
final isLookingAndKnowJobProvider = StateProvider<bool>((ref) => false);
final isUnDegreeProvider = StateProvider<bool>((ref) => false);
final locationProvider = StateProvider<TextEditingController>((ref) => TextEditingController());
final jobsProvider = StateProvider<TextEditingController>((ref) => TextEditingController());
final imagePathProvider = StateProvider<String>((ref) => '');

//Home Screen
final cardIndexProvider = StateProvider<int>((ref) => 0);
final swiperControllerProvider = StateProvider<SwiperController>((ref) => SwiperController());


