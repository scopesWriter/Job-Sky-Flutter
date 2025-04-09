import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/message_model.dart';

class MessageProvider with ChangeNotifier {
  List<Message> _messages = [];

  List<Message> get messages => _messages;

  void addMessage(Message message) {
    _messages.insert(0, message); // Insert at the top (for latest messages)
    notifyListeners(); // Notify listeners (UI) when data changes
  }
}

 // Your message model

// Define a StateNotifier to manage message state
class MessageNotifier extends StateNotifier<List<Message>> {
  MessageNotifier() : super([]);

  void addMessage(Message message) {
    state = [message, ...state]; // Add new message at the start
  }
}

// Create a Riverpod provider for message state
final messageProvider = StateNotifierProvider<MessageNotifier, List<Message>>(
      (ref) => MessageNotifier(),
);
