import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/user_model.dart';
import '../../../providers/friend_profile.dart';
import '../../auth/external_functions/uid_functions.dart';
import '../friend_profile_screen.dart';

void showUsersList(BuildContext context, List<UserModel> users , WidgetRef ref) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        color: Colors.grey[100],
        height: MediaQuery.of(context).size.height * 0.8,
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return GestureDetector(
              onTap: () async {
                final uid = await getUid();
                ref.read(isFollowProvider.notifier).state = false;
                for (var i = 0; i < user.followers.length; i++) {
                  if (user.followers[i] == uid) {
                    ref.read(isFollowProvider.notifier).state = true;
                    break;
                  }
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FriendProfileScreen(data: user),
                  ),
                );
              },
              child: Container(
                margin:  const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                padding:  const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300]!,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    user.profileImage != ''
                        ? ClipOval(
                      child: Image.memory(
                        base64Decode(
                          user.profileImage!.split(',').last,
                        ),
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    )
                        : CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.grey[300],
                      child: Icon(Icons.camera_alt, size: 20, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.userName,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),

                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
