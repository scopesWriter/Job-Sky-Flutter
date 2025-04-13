import 'package:flutter/material.dart';
import '../../core/firebase_auth_service/profile/friends_follow.dart';

class FriendsListViewModel extends ChangeNotifier {
  final FriendsListService friendsListService = FriendsListService();

  Future<void> addFriend({
    required String friendId,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) async {
    // notifyListeners();

    try {
      await friendsListService.addFriend(friendId);
      onSuccess();
    } catch (e) {
      onFailure();
      print('-----------------------------------------------------');
      print('Error: $e'); 
    } finally {}
  }
  Future<void> deleteFriend({
    required String friendId,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) async {
    // notifyListeners();

    try {
      await friendsListService.deleteFriend(friendId);
      onSuccess();
    } catch (e) {
      onFailure();
      print('-----------------------------------------------------');
      print('Error: $e');
    } finally {}
  }
}
