import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String text;
  final Timestamp timestamp;
  final String senderId;
  final String receiverId;
  bool isSent;

  Message({
    required this.text,
    required this.timestamp,
    required this.senderId,
    required this.receiverId,
    this.isSent = false,
  });

  factory Message.fromFirestore(Map<String, dynamic> data) {
    return Message(
      text: data['text'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
      senderId: data['senderId'] ?? '',
      receiverId: data['receiverId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'timestamp': timestamp,
      'senderId': senderId,
      'receiverId': receiverId,
    };
  }
}
