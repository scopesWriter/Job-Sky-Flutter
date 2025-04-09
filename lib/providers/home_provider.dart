
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Bottom Navigation
final bottomIndexProvider = StateProvider<int>((ref) => 0); //index



//Home Screen
final cardIndexProvider = StateProvider<int>((ref) => 0);
final swiperControllerProvider = StateProvider<SwiperController>((ref) => SwiperController());


