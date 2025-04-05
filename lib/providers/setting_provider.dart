import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


//Change Password
final newPasswordProvider = StateProvider.autoDispose<TextEditingController>((ref) => TextEditingController());
final confirmNewPasswordProvider = StateProvider.autoDispose<TextEditingController>((ref) => TextEditingController());
final oldPasswordProvider = StateProvider.autoDispose<TextEditingController>((ref) => TextEditingController());
final obscureNewPasswordProvider = StateProvider<bool>((ref) => true);
final obscureConfirmNewPasswordProvider = StateProvider<bool>((ref) => true);
final obscureOldPasswordProvider = StateProvider<bool>((ref) => true);