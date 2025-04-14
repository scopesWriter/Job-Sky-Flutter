import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:job_sky/providers/home_provider.dart';
import '../../core/theme/app_colors.dart';
import 'external_functions/make_home_cards.dart';

class HomeScreen extends ConsumerStatefulWidget {
  HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with RouteAware {

  @override
  void initState() {
    super.initState();

    // Delay the provider modification until after the widget tree is built
    Future(() {
      ref.read(cardsProvider.notifier).state = [];
      ref.invalidate(cardsDataProvider);
    });
  }



  @override
  Widget build(BuildContext context) {
    // ref.invalidate(cardsDataProvider);
    final cardsDataAsync = ref.watch(cardsDataProvider);
    final swiperController = ref.watch(swiperControllerProvider);

    return cardsDataAsync.when(
      data: (data) {
        final cards = ref.watch(cardsProvider);

        if (cards.isEmpty) {
          // Using Future to update the cards state asynchronously
          Future(() {
            ref.read(cardsProvider.notifier).state = makeCard(data);
          });
        }

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
                    onTap: (index) =>
                    ref.read(cardIndexProvider.notifier).state = index,
                    onIndexChanged: (index) =>
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
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => Center(child: CircularProgressIndicator(color: AppColors.loadingColor)),
    );
  }
}
