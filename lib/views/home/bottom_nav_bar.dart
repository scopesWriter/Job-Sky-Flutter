import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_sky/core/theme/app_colors.dart';
import 'package:job_sky/models/user_model.dart';
import 'package:job_sky/viewmodels/home/get_cards_data.dart';
import 'package:job_sky/views/auth/external_functions/uid_functions.dart';
import 'package:job_sky/views/home/home_screen.dart';
import 'package:job_sky/views/home/profile_screen.dart';
import '../../providers/home_provider.dart';
import '../../providers/profile_provider.dart';
import '../../viewmodels/auth/store_Location_viewmodel.dart';
import 'chat_list_screen.dart';
import 'external_functions/make_home_cards.dart';

class BottomNavBar extends ConsumerWidget {
  BottomNavBar({super.key});


  final cardsDataProvider = StreamProvider<List<UserModel>>((ref) async* {
    final uid = await getUid();
    final cardsDataViewModel = CardsDataViewModel();

    yield* cardsDataViewModel.getUserStream().map((allCards) {
      final userCard = allCards.firstWhere(
            (card) => card.uid == uid,
        orElse: () => UserModel(
          uid: '',
          email: '',
          userName: '',
          phoneNumber: '',
          profileImage: '',
        ),
      );
      final otherCards = allCards.where((card) => card.uid != uid).toList();
      return [userCard, ...otherCards];
    });
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomIndex = ref.watch(bottomIndexProvider);
    final cardsDataAsync = ref.watch(cardsDataProvider);

    final storeLocation = StoreLocationViewmodel();
    storeLocation.storeUserLocation(context: context, ref: ref);
    return cardsDataAsync.when(
      data: (data) {
        final homeCards = makeCard(data);
        final List<Widget> _screens = [
          HomeScreens(cards:  homeCards),
          ChatListScreen(data: data,),
          ProfileScreen(data: data[0]),
        ];
        return Scaffold(
          body: _screens[bottomIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: AppColors.authButtonColor,
            backgroundColor: Colors.white,
            currentIndex: bottomIndex,
            onTap: (index) {
              ref.read(isPublicProvider.notifier).state = data[0].isPublic;
              ref.read(selectedDistanceProvider.notifier).state = data[0].distance;
              ref.read(isLookingAndKnowJobProvider.notifier).state =
                  data[0].isLookingAndKnowJob;
              ref.read(isUnDegreeProvider.notifier).state = data[0].isUnDegree;
              ref.read(locationProvider.notifier).state = TextEditingController(
                text: data[0].location,
              );
              ref.read(jobsProvider.notifier).state = TextEditingController(
                text: data[0].jobs,
              );
              ref.read(bottomIndexProvider.notifier).state = index;
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.message),
                label: 'Messages',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('Error: $err')),
    );
  }
}


