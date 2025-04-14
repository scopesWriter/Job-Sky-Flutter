import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../views/auth/external_functions/uid_functions.dart';

class StartChatService {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<DateTime?> getChatStartDate(String friendId) async {
    final uid = await getUid();
    final chatId = _generateChatId(friendId, uid!);

    final snapshot =
        await FirebaseFirestore.instance.collection('chats').doc(chatId).get();

    if (snapshot.exists) {
      final data = snapshot.data();
      if (data?['senderRate'] != uid && data?['receiverRate'] != uid) {
        final createdAt = data?['createdAt'] as Timestamp;
        return createdAt.toDate();
      }
      return null;
    }
    return null;
  }

  Future<void> setUserChatRate(String friendId, int rate) async {
    try {
      final uid = await getUid();
      final chatId = _generateChatId(friendId, uid!);

      final chatsSnapshot =
          await FirebaseFirestore.instance
              .collection('chats')
              .doc(chatId)
              .get();

      if (chatsSnapshot.exists) {
        final data = chatsSnapshot.data();
        if (data?['senderRate'] == '') {
          await FirebaseFirestore.instance
              .collection('chats')
              .doc(chatId)
              .update({'senderRate': uid});
        } else {
          await FirebaseFirestore.instance
              .collection('chats')
              .doc(chatId)
              .update({'receiverRate': uid});
        }
        final usersSnapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(friendId)
                .get();

        final friendData = usersSnapshot.data();
        final rates = List<int>.from(friendData?['rates'] ?? []);
        rates.add(rate);
        if (rate != 0) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(friendId)
              .update({'rates': rates});
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}

String _generateChatId(String uid1, String uid2) {
  return uid1.compareTo(uid2) < 0 ? '$uid1\_$uid2' : '$uid2\_$uid1';
}
