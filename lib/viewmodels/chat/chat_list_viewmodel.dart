import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/chat_list_model.dart';

final chatListProvider = StreamProvider<List<ChatPreview>>((ref) async* {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  if (userId == null) yield [];

  final chatSnapshots = FirebaseFirestore.instance
      .collection('chats')
      .where('participants', arrayContains: userId)
      .orderBy('lastTimestamp', descending: true)
      .snapshots();

  await for (final snapshot in chatSnapshots) {
    final chats = await Future.wait(snapshot.docs.map((doc) async {
      final data = doc.data();
      final participants = List<String>.from(data['participants']);
      final friendId = participants.firstWhere((id) => id != userId);

      // Get last message from subcollection
      final messagesSnapshot = await FirebaseFirestore.instance
          .collection('chats')
          .doc(doc.id)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      final lastMessage = messagesSnapshot.docs.isNotEmpty
          ? messagesSnapshot.docs.first.data()['text']
          : '';

      return ChatPreview(
        chatId: doc.id,
        friendId: friendId,
        lastMessage: lastMessage,
      );
    }).toList());

    yield chats;
  }
});
