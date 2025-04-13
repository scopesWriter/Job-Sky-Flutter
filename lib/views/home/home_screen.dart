import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:job_sky/providers/home_provider.dart';

class HomeScreens extends ConsumerWidget {
  HomeScreens({super.key, required this.cards});

  List<Container> cards ;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final swiperController = ref.watch(swiperControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            children: [
              Text(
                'Job Sky',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Swiper(
                itemCount: cards.length,
                itemBuilder: (context, index) => cards[index],
                onTap:
                    (index) =>
                        ref.read(cardIndexProvider.notifier).state = index,
                onIndexChanged:
                    (index) =>
                        ref.read(cardIndexProvider.notifier).state = index,
                loop: false,
                controller: swiperController,

                itemWidth: MediaQuery.of(context).size.width,
                itemHeight: MediaQuery.of(context).size.height * 0.8,
                layout: SwiperLayout.TINDER,
                index: ref.watch(cardIndexProvider),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

