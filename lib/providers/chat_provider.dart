

//Chat List
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/firebase_auth_service/chat/chat_list.dart';

final chatsIdListProvider = FutureProvider.autoDispose<List<String>>((ref) =>  ChatService(firestore: FirebaseFirestore.instance).loadChatIds());