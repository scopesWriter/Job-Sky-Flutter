import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/message_model.dart';

class ChatViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference _messagesCollection;
  final String friendId; // Use friendId (userId of the friend) instead of friendName

  // List of messages to be displayed
  List<Message> _messages = [];
  List<Message> get messages => _messages;

  List<String> _chatIds = []; // List of chat IDs
  List<String> get chatIds => _chatIds;  // Expose chatIds


  ChatViewModel({required this.friendId, required String friendName}) {
    _initializeChat();
  }

  // Initialize the chat collection based on the current user and the friendId
  void _initializeChat() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final currentUserId = currentUser.uid;

      // Create a consistent chat ID using both user IDs (lexicographically sorted)
      final chatId = currentUserId.compareTo(friendId) < 0
          ? '$currentUserId\_$friendId'
          : '$friendId\_$currentUserId';

      _messagesCollection = _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages');
      loadMessages(); // Load messages immediately
    }
  }

  void loadMessages() {
    _messagesCollection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      List<Message> fetchedMessages = snapshot.docs.map((doc) {
        // Map each document to a Message object
        Message message = Message.fromFirestore(doc.data() as Map<String, dynamic>);

        print('Loaded message: ${message.text}, SenderId: ${message.senderId}, ReceiverId: ${message.receiverId}');

        // Set isSent based on whether the current user is the sender
        if (message.senderId == FirebaseAuth.instance.currentUser!.uid) {
          message.isSent = true;  // It's a sent message
        } else {
          message.isSent = false; // It's a received message
        }

        return message;
      }).toList();

      // Remove duplicates before updating _messages list
      List<Message> newMessages = [];
      for (var newMessage in fetchedMessages) {
        if (!_messages.any((message) => message.timestamp == newMessage.timestamp)) {
          newMessages.add(newMessage);
        }
      }

      // Update the list only if there are new messages
      if (newMessages.isNotEmpty) {
        _messages = newMessages + _messages;  // Add new messages at the start of the list
        notifyListeners(); // Notify listeners for UI update
      }
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
      final friendUserId = friendId; // The ID of the friend you're chatting with

      // Create a consistent chat ID using both user IDs (lexicographically sorted)
      final chatId = currentUserId.compareTo(friendUserId) < 0
          ? '$currentUserId\_$friendUserId'
          : '$friendUserId\_$currentUserId';

      final message = Message(
        text: text,
        timestamp: Timestamp.now(),
        senderId: currentUserId,
        receiverId: friendUserId,
        isSent: true, // Set the senderId to the current user and isSent to true
      );

      // Add the message to Firestore (without adding it to the local list here)
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId)  // Use the combined chatId
          .collection('messages')
          .add({
        'text': message.text,
        'timestamp': message.timestamp,
        'senderId': message.senderId,
      });

      // No need to insert the message in _messages here, as it's already handled by loadMessages.
      // _messages.insert(0, message);
      // notifyListeners(); // Don't call this here as loadMessages will handle it

    } catch (e) {
      print('Error sending message: $e');
    }
  }


  // Fetch messages manually, if needed
  Future<void> fetchMessages() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print("User not authenticated");
        return;
      }

      final currentUserId = currentUser.uid;
      final friendUserId =
          friendId; // The ID of the friend you're chatting with

      // Create the chat ID using both user IDs (lexicographically sorted)
      final chatId =
      currentUserId.compareTo(friendUserId) < 0
          ? '$currentUserId\_$friendUserId'
          : '$friendUserId\_$currentUserId';

      // Fetch messages from Firestore
      final messagesSnapshot =
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId) // Use the same chatId
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .get();

      final List<Message> messages =
      messagesSnapshot.docs
          .map((doc) => Message.fromFirestore(doc.data()))
          .toList();

      // Update your messages list
      _messages = messages;
      notifyListeners();
    } catch (e) {
      print('Error fetching messages: $e');
    }
  }

  // Fetch all chat IDs for the current user
  void loadChats() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      try {
        // Query for all chat documents where the current user is either the sender or receiver
        final chatSnapshot = await _firestore
            .collection('chats')
            .where('participants', arrayContains: currentUser.uid) // Assuming participants array stores user ids
            .get();

        // Extract chat IDs from the result
        _chatIds = chatSnapshot.docs.map((doc) => doc.id).toList();

        notifyListeners();  // Notify listeners to update the UI
      } catch (e) {
        print('Error loading chats: $e');
      }
    }
  }
}
