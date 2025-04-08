import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveUidLocally(String uid) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('uid', uid);
}

Future<String?> getUid() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('uid');
}

Future<void> clearUid() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('uid');
}

Future<bool> isUserLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.containsKey('uid');
}