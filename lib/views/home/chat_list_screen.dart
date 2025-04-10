import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_sky/models/user_model.dart';
import '../../viewmodels/chat/chat_list_viewmodel.dart';
import '../chat/chat_screen.dart';


class ChatListScreen extends ConsumerStatefulWidget {
  const ChatListScreen({super.key, required this.data});
  final List<UserModel> data;

  @override
  ConsumerState<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends ConsumerState<ChatListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.refresh(chatListProvider));
  }


  @override
  Widget build(BuildContext context) {
    final chatListAsync = ref.watch(chatListProvider);
    List<UserModel> friendData = [];

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

          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index];
              for (final friendChat in widget.data) {
                if (chat.friendId == friendChat.uid) {
                  friendData.add(friendChat);
                }
              }

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(
                        friendId: chat.friendId,
                        friendName: friendData[index].userName,
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
                        friendData[index].profileImage != ''
                            ? ClipOval(
                          child: Image.memory(
                            base64Decode(
                              friendData[index].profileImage!.split(',').last,
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
                                friendData[index].userName,
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
}
