import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_sky/models/user_model.dart';
import 'package:job_sky/providers/friend_profile.dart';
import 'package:job_sky/widgets/custom_alert.dart';
import 'package:job_sky/widgets/custom_buttons.dart';
import '../../core/theme/app_colors.dart';
import '../../viewmodels/profile/friend_follow.dart';

class FriendProfileScreen extends ConsumerWidget {
  FriendProfileScreen({super.key, required this.data});

  final UserModel data;
  final friendViewModel = FriendsListViewModel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFollowing = ref.watch(isFollowProvider);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Profile', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile Picture
            Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[300]!,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: CircleAvatar(
                backgroundColor: Colors.grey[300],
                backgroundImage:
                    data.profileImage != ""
                        ? MemoryImage(
                          base64Decode(data.profileImage!.split(',').last),
                        )
                        : null,
                child:
                    data.profileImage!.isEmpty
                        ? const Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.white,
                        )
                        : null,
              ),
            ),
            const SizedBox(height: 16),

            // Name
            Text(
              data.userName == '' ? 'Unknown' : data.userName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            CustomButton(
              buttonName: isFollowing ? 'Following' : 'Follow',
              backgroundColor:
                  isFollowing ? Colors.grey[200]! : AppColors.authButtonColor,
              foregroundColor: isFollowing ? Colors.green[500]! : Colors.white,
              borderRadius: 15,
              onTap: () {
                if (!isFollowing) {
                  friendViewModel.addFriend(
                    friendId: data.uid,
                    onSuccess: () {
                      ref.read(isFollowProvider.notifier).state = !isFollowing;
                    },
                    onFailure: () {
                      OneButtonAlert(
                        context,
                        "Oops!",
                        "Something went wrong",
                        () {
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                } else {
                  friendViewModel.deleteFriend(
                    friendId: data.uid,
                    onSuccess: () {
                      ref.read(isFollowProvider.notifier).state = !isFollowing;
                    },
                    onFailure: () {
                      OneButtonAlert(
                        context,
                        "Oops!",
                        "Something went wrong",
                            () {
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                }
              },
            ),
            // Info Cards
            _buildInfoCard(
              Icons.phone,
              "Phone",
              data.phoneNumber == '' ? 'Unknown' : data.phoneNumber,
            ),
            _buildInfoCard(
              Icons.location_on,
              "Location",
              data.location == '' ? 'Unknown' : data.location,
            ),
            _buildInfoCard(
              Icons.work,
              "Jobs",
              data.jobs == '' ? 'Unknown' : data.jobs.split(',').join(', '),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildInfoCard(IconData icon, String title, String value) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(16),
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.grey[100]!,
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(icon, color: AppColors.authButtonColor),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ],
    ),
  );
}
