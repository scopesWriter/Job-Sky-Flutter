import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_sky/core/theme/app_colors.dart';
import 'package:job_sky/views/home/home_screen.dart';
import 'package:job_sky/views/home/profile_screen.dart';
import '../../providers/home_provider.dart';
import '../../viewmodels/auth/store_Location_viewmodel.dart';
import 'chat_list_screen.dart';

class BottomNavBar extends ConsumerWidget {
  BottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomIndex = ref.watch(bottomIndexProvider);
    final List<Widget> _screens = [
      HomeScreens(),
      ChatListScreen(),
      ProfileScreen(),
    ];

    final storeLocation = StoreLocationViewmodel();
    storeLocation.storeUserLocation(context: context, ref: ref);
    return Scaffold(
      body: _screens[bottomIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.authButtonColor,
        backgroundColor: Colors.white,
        currentIndex: bottomIndex,
        onTap: (index) {

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
}

}
