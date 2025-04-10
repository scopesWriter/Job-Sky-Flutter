import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/message_model.dart';

class ChatViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String friendId;
  late CollectionReference _messagesCollection;

  final List<Message> _messages = [];
  List<Message> get messages => _messages;

  StreamSubscription? _messagesSubscription;

  ChatViewModel({required this.friendId, required String friendName}) {
    _initializeChat();
  }

  void _initializeChat() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final currentUserId = currentUser.uid;
      final chatId = _generateChatId(currentUserId, friendId);

      _messagesCollection = _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages');

      _listenToMessages();
    }
  }

  String _generateChatId(String uid1, String uid2) {
    return uid1.compareTo(uid2) < 0 ? '$uid1\_$uid2' : '$uid2\_$uid1';
  }

  void _listenToMessages() {
    _messagesSubscription = _messagesCollection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;

      final fetchedMessages = snapshot.docs.map((doc) {
        final message = Message.fromFirestore(doc.data() as Map<String, dynamic>);
        message.isSent = message.senderId == currentUserId;
        return message;
      }).toList();

      _messages.clear();
      _messages.addAll(fetchedMessages);
      notifyListeners();
    }, onError: (e) {
      print('Error in messages listener: $e');
    });
  }

  Future<void> sendMessage(String text) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print("User not authenticated");
        return;
      }

      final currentUserId = currentUser.uid;
      final chatId = _generateChatId(currentUserId, friendId);

      // Create the chat document if it doesn't exist
      final chatDocRef = _firestore.collection('chats').doc(chatId);
      final chatDoc = await chatDocRef.get();
      if (!chatDoc.exists) {
        await chatDocRef.set({
          'participants': [currentUserId, friendId],
          'createdAt': FieldValue.serverTimestamp(),
          'lastMessage': text,
          'lastTimestamp': FieldValue.serverTimestamp(),
        });
      } else {
        // Optionally update the last message
        await chatDocRef.update({
          'lastMessage': text,
          'lastTimestamp': FieldValue.serverTimestamp(),
        });
      }

      final message = Message(
        text: text,
        timestamp: Timestamp.now(),
        senderId: currentUserId,
        receiverId: friendId,
        isSent: true,
      );

      await chatDocRef.collection('messages').add({
        'text': message.text,
        'timestamp': message.timestamp,
        'senderId': message.senderId,
      });

    } catch (e) {
      print('Error sending message: $e');
    }
  }


  Future<void> fetchMessages() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) return;

      final currentUserId = currentUser.uid;
      final chatId = _generateChatId(currentUserId, friendId);

      final snapshot = await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .get();

      final fetchedMessages = snapshot.docs.map((doc) {
        final message = Message.fromFirestore(doc.data());
        message.isSent = message.senderId == currentUserId;
        return message;
      }).toList();

      _messages.clear();
      _messages.addAll(fetchedMessages);
      notifyListeners();
    } catch (e) {
      print('Error fetching messages: $e');
    }
  }

  @override
  void dispose() {
    _messagesSubscription?.cancel();
    super.dispose();
  }
}