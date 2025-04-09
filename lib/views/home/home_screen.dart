import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:job_sky/providers/home_provider.dart';
import '../../widgets/home_card.dart';

class HomeScreens extends ConsumerWidget {
  HomeScreens(  {super.key, required this.cardsData});

  final cardsData ;

  List<Container> cards = [];

  void makeCard() {
    if (cards.isNotEmpty) {
      return;
    }
    // print('cardsData: ${cardsData.l}');
    for (int i = 0; i < cardsData.length; i++) {
      cards.add(Container(child: HomeCart(data: cardsData[i], cardsNumber: cardsData.length,)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    makeCard();

    final  swiperController = ref.watch(swiperControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(

            children: [
              Text('Job Sky',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              Swiper(
                itemCount: cards.length,
                itemBuilder: (context, index) => cards[index],
                onTap:
                    (index) => ref.read(cardIndexProvider.notifier).state = index,
                onIndexChanged:
                    (index) => ref.read(cardIndexProvider.notifier).state = index,
                loop: false,
                controller: swiperController,

                itemWidth: MediaQuery.of(context).size.width,
                itemHeight: MediaQuery.of(context).size.height*0.8,
                layout: SwiperLayout.TINDER ,
                index: ref.watch(cardIndexProvider),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
