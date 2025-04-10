import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_sky/core/theme/app_colors.dart';
import 'package:job_sky/models/user_model.dart';
import 'package:job_sky/views/chat/chat_screen.dart';
import '../providers/home_provider.dart';
import '../views/home/friend_profile_screen.dart';
import 'home_card_button.dart';

class HomeCart extends ConsumerWidget {
  HomeCart({super.key, required this.data, required this.cardsNumber});

  final UserModel data;
  final cardsNumber;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => FriendProfileScreen(data: data,)));
      },
      child: Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(color: Colors.white, width: 1.0),
      ),
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage:
              data.profileImage == ''
                  ? AssetImage('assets/images/no_image.png')
                  : Image
                  .memory(
                base64Decode(data.profileImage!.split(',').last),
                fit: BoxFit.cover,
              )
                  .image,),
            const SizedBox(height: 10),
            Text(
              data.userName == '' ? 'Unknown' : data.userName,
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              data.location == '' ? 'Unknown Location' : data.location,
              style: TextStyle(color: Colors.grey[600], fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Text(
              data.jobs == '' ? 'Unknown interesting jobs' : data.jobs,
              style: TextStyle(color: Colors.grey[700], fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Text(
              data.isUnDegree == true
                  ? 'Degree Required: Yes'
                  : 'Degree Required: No',
              style: TextStyle(color: Colors.teal, fontSize: 18),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                HomeCardButton(
                  icon: Icons.refresh_sharp,
                  iconColor: Colors.green[400]!,
                  onPressed: () async {
                    await Future.delayed(const Duration(milliseconds: 100));
                    if (ref.watch(cardIndexProvider) > 0) {
                      ref.read(swiperControllerProvider).previous();
                    }
                  },
                ),
                SizedBox(
                  width: 150,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonColor,
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                              ChatScreen(
                                friendName: data.userName, friendId: data.uid,),
                        ),
                      );
                    },
                    child: const Text(
                      'Open Chat',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                HomeCardButton(
                  icon: Icons.close_sharp,
                  iconColor: Colors.red[600]!,
                  onPressed: () async {
                    if (ref.watch(cardIndexProvider) < cardsNumber - 1) {
                      await Future.delayed(const Duration(milliseconds: 100));
                      ref.read(swiperControllerProvider).next();
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    ),);
  }
}
