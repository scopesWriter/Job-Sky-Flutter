import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:job_sky/providers/home_provider.dart';

import '../../widgets/home_card.dart';

class HomeScreens extends ConsumerWidget {
  HomeScreens({super.key});

  final dataList = [
    {
      "name": "John Doe1",
      "job": "Flutter Developer",
      "image":
          "https://images.unsplash.com/photo-1511367442022-f34c924f6f51?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
      "location": "New York, USA",
      "experience": "3 years",
      "education": "Bachelor of Science in Computer Science",
      "skills": "swift, Dart, Firebase",
    },
    {
      "name": "John Doe2",
      "job": "iOS Developer",
      "image":
          "https://images.unsplash.com/photo-1511367442022-f34c924f6f51?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
      "location": "New York, USA",
      "experience": "4 years",
      "education": "Bachelor of Science in Computer Science",
      "skills": "Kotlin, Dart, Firebase",
    },
    {
      "name": "John Doe3",
      "job": "Flutter Developer",
      "image":
          "https://images.unsplash.com/photo-1511367442022-f34c924f6f51?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
      "location": "Germany, Berlin",
      "experience": "1 years",
      "education": "Bachelor of Science in Computer Science",
      "skills": "Flutter, Dart, Firebase",
    },
    {
      "name": "John Doe4",
      "job": "Flutter Developer",
      "image":
          "https://images.unsplash.com/photo-1511367442022-f34c924f6f51?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
      "location": "Egypt, Cairo",
      "experience": "2 years",
      "education": "Bachelor of Science in Computer Science",
      "skills": "Flutter, Dart, Firebase",
    },
    {
      "name": "Martin",
      "job": "Android Developer",
      "image":
      "https://images.unsplash.com/photo-1511367442022-f34c924f6f51?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
      "location": "Egypt",
      "experience": "5 years",
      "education": "Bachelor of Science ",
      "skills": "Java, Dart, Firebase",
    },
  ];

  List<Container> cards = [];

  void makeCard() {
    if (cards.isNotEmpty) {
      return;
    }
    for (int i = 0; i < dataList.length; i++) {
      cards.add(Container(child: HomeCart(data: dataList[i], cardsNumber: dataList.length,)));
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
