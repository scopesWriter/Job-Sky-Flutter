import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_sky/core/theme/app_colors.dart';
import 'package:job_sky/models/user_model.dart';
import 'package:job_sky/views/home/home_screen.dart';
import 'package:job_sky/views/home/message_screen.dart';
import 'package:job_sky/views/home/profile_screen.dart';
import '../../providers/home_provider.dart';
import '../../viewmodels/home/profile_image_viewmodel.dart';


class BottomNavBar extends ConsumerWidget {
  BottomNavBar({super.key});

  final userDataProvider = FutureProvider<UserModel>((ref) async {
    final profileViewModel = ProfileImageViewModel();
    final userData = await profileViewModel.getUserData();
    print('✅ Updated data: ${userData.toMap()}');
    return userData;
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomIndex = ref.watch(bottomIndexProvider);
    final userDataAsync = ref.watch(userDataProvider);



    return userDataAsync.when(data: (data)
    {
      final List<Widget> _screens = [
        HomeScreens(),
        MessageScreen(),
        ProfileScreen(data: data),
      ];
        return Scaffold(
          body: _screens[bottomIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: AppColors.authButtonColor,
            backgroundColor: Colors.white,
            currentIndex: bottomIndex,
            onTap: (index) {
              ref.read(isPublicProvider.notifier).state = data.isPublic;
              ref.read(isLookingAndKnowJobProvider.notifier).state = data.isLookingAndKnowJob;
              ref.read(isUnDegreeProvider.notifier).state = data.isUnDegree;
              ref.read(locationProvider.notifier).state = TextEditingController(text: data.location);
              ref.read(jobsProvider.notifier).state = TextEditingController(text: data.jobs);
              ref.read(bottomIndexProvider.notifier).state = index;},
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
        );
    },
    loading: () => const Center(child: CircularProgressIndicator()),
    error: (err, _) => Center(child: Text('Error: $err'))
  );
  }
}