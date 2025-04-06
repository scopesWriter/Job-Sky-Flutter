import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:job_sky/providers/home_provider.dart';

import '../../widgets/home_card.dart';

class HomeScreens extends ConsumerWidget {
  HomeScreens({super.key});

  final dataList = [
    {
      "name"  : "John Doe1",
      "job"   : "Flutter Developer",
      "image" : "https://images.unsplash.com/photo-1511367442022-f34c924f6f51?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
      "location" : "New York, USA",
      "experience" : "3 years",
      "education" : "Bachelor of Science in Computer Science",
      "skills" : "swift, Dart, Firebase",
    },
    {
      "name"  : "John Doe2",
      "job"   : "iOS Developer",
      "image" : "https://images.unsplash.com/photo-1511367442022-f34c924f6f51?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
      "location" : "New York, USA",
      "experience" : "4 years",
      "education" : "Bachelor of Science in Computer Science",
      "skills" : "Kotlin, Dart, Firebase",
    } ,
    {
      "name"  : "John Doe3",
      "job"   : "Flutter Developer",
      "image" : "https://images.unsplash.com/photo-1511367442022-f34c924f6f51?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
      "location" : "Germany, Berlin",
      "experience" : "1 years",
      "education" : "Bachelor of Science in Computer Science",
      "skills" : "Flutter, Dart, Firebase",
    },
    {
      "name"  : "John Doe4",
      "job"   : "Flutter Developer",
      "image" : "https://images.unsplash.com/photo-1511367442022-f34c924f6f51?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
      "location" : "Egypt, Cairo",
      "experience" : "2 years",
      "education" : "Bachelor of Science in Computer Science",
      "skills" : "Flutter, Dart, Firebase",
    }
  ];


  List<Container> cards = [];

  void makeCard() {
    if (cards.isNotEmpty) {return ;}
    for (int i = 0; i < dataList.length ; i++) {
      cards.add(Container(child: HomeCart(data: dataList[i],)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    makeCard();
    final PageController _pageController = PageController();

    int _currentIndex = ref.watch(cardIndexProvider);

    void _goNext() {
      if (_currentIndex < cards.length - 1) {
        // Trigger next swipe
        _pageController.animateToPage(
          ref.read(cardIndexProvider) + 1,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }

    void _goPrevious() {
      if (_currentIndex > 0) {
        // Trigger previous swipe
        _pageController.animateToPage(
          ref.read(cardIndexProvider) - 1,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: cards.length,
                  onPageChanged: (index) {

                      ref.read(cardIndexProvider.notifier).state = index;
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: Color(0xFFE5E5E5),
                      child: Center(child: Container(child: cards[index])),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: _goPrevious, icon: Icon(Icons.arrow_back)),
                  IconButton(onPressed: _goNext, icon: Icon(Icons.arrow_forward)),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

