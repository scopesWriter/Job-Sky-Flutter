import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_sky/core/theme/app_colors.dart';
import 'package:job_sky/views/home/home_screen.dart';
import 'package:job_sky/views/home/message_screen.dart';
import 'package:job_sky/views/home/profile_screen.dart';

import '../../providers/home_provider.dart';

class BottomNavBar extends ConsumerWidget {
   BottomNavBar({super.key});


  final List<Widget> _screens = [
    HomeScreen(),
    MessageScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final bottomIndex = ref.watch(bottomIndexProvider);
    return Scaffold(
      body: _screens[bottomIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.authButtonColor,
        backgroundColor: Colors.white,
        currentIndex: bottomIndex,
        onTap: (index) => ref.read(bottomIndexProvider.notifier).state = index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
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
