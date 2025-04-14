import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_sky/models/user_model.dart';
import '../../providers/home_provider.dart';
import '../../viewmodels/chat/chat_list_viewmodel.dart';
import '../chat/chat_screen.dart';


class ChatListScreen extends ConsumerStatefulWidget {
  const ChatListScreen({super.key});


  @override
  ConsumerState<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends ConsumerState<ChatListScreen> {
  List<UserModel> data = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final user = await ref.watch(cardsDataProvider.future);
      setState(() {
        data = user; // Wrap in list if needed
      });
      ref.refresh(chatListProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatListAsync = ref.watch(chatListProvider);

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        title: const Text('Chats'),
        centerTitle: true,
      ),
      body: chatListAsync.when(
        data: (chats) {
          if (chats.isEmpty) {
            return const Center(child: Text("No chats yet."));
          }

          // Precompute friendData to match chats
          List<UserModel?> friendData = [];
          for (final chat in chats) {
            final friend = data.firstWhere(
                  (user) => user.uid == chat.friendId,
              orElse: () => UserModel( uid: '', email: '', userName: '', phoneNumber: '', profileImage: ''),
            );
            friendData.add(friend);
          }

          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index];
              final friend = friendData[index];

              // Handle case where friend is not found
              if (friend == null || friend.userName.isEmpty) {
                return ListTile(
                  title: const Text("Unknown User"),
                  subtitle: Text(chat.lastMessage),
                );
              }

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(
                        friendId: chat.friendId,
                        friendName: friend.userName,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Container(
                    padding: const EdgeInsets.all(12),
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
                        buildProfileImage(friend),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                friend.userName.isNotEmpty ? friend.userName : 'Unknown User',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                chat.lastMessage,
                                style: TextStyle(color: Colors.grey[600]),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget buildProfileImage(UserModel friend) {
    if (friend.profileImage != '') {
      try {
        return ClipOval(
          child: Image.memory(
            base64Decode(friend.profileImage!.split(',').last),
            width: 70,
            height: 70,
            fit: BoxFit.cover,
          ),
        );
      } catch (e) {
        debugPrint('Error decoding profile image: $e');
        return CircleAvatar(
          radius: 35,
          backgroundColor: Colors.grey[300],
          child: Icon(Icons.error, size: 20, color: Colors.white),
        );
      }
    }
    return CircleAvatar(
      radius: 35,
      backgroundColor: Colors.grey[300],
      child: Icon(Icons.person, size: 20, color: Colors.white),
    );
  }
}