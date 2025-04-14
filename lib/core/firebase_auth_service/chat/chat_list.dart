import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/user_model.dart';
import '../../../views/auth/external_functions/uid_functions.dart';

class ChatService {
  final FirebaseFirestore firestore;

  ChatService({required this.firestore});

  Future<List<String>> loadChatIds() async {
    final uid = await getUid();
    final chatSnapshots = await firestore.collection('chats').get();
    List<String> chatIds = [];

    for (var chatDoc in chatSnapshots.docs) {
      final chatId = chatDoc.id;
      if (chatId.contains(uid!)) {
        chatIds.add(chatId);
      }
    }

    return chatIds;
  }
}

class MessageService {
  final FirebaseFirestore firestore;

  MessageService({required this.firestore});

  Future<Map<String, dynamic>> loadLastMessage(String chatId) async {
    final messagesSnapshot = await firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    if (messagesSnapshot.docs.isNotEmpty) {
      final lastMessageData = messagesSnapshot.docs.first.data();
      return {
        'lastMessage': lastMessageData['text'] ?? '',
        'timestamp': lastMessageData['timestamp']?.toDate() ?? DateTime.now(),
        'senderId': lastMessageData['senderId'] ?? '',
      };
    }
    return {};
  }
}

class UserService {
  final List<UserModel> allUsers;

  UserService({required this.allUsers});

  UserModel getReceiver(String chatId, String currentUserId) {
    final receiverId = chatId.replaceAll(currentUserId, '').replaceAll('_', '');
    return allUsers.firstWhere(
          (user) => user.uid == receiverId,
      orElse: () => UserModel(uid: receiverId, email: '', userName: 'Unknown', phoneNumber: ''),
    );
  }
}
