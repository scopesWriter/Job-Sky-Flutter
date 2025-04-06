import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Login Screen
final loginObscurePasswordProvider = StateProvider<bool>((ref) => true);
final loginEmailProvider = StateProvider.autoDispose<TextEditingController>((ref) => TextEditingController());
final loginPasswordProvider = StateProvider.autoDispose<TextEditingController>((ref) => TextEditingController());


// Signup Screen
final userNameProvider = StateProvider.autoDispose<TextEditingController>((ref) => TextEditingController());
final emailProvider = StateProvider.autoDispose<TextEditingController>((ref) => TextEditingController());
final passwordProvider = StateProvider.autoDispose<TextEditingController>((ref) => TextEditingController());
final phoneNumberProvider = StateProvider.autoDispose<TextEditingController>((ref) => TextEditingController());
final confirmPasswordProvider = StateProvider.autoDispose<TextEditingController>((ref) => TextEditingController());
final obscurePasswordProvider = StateProvider<bool>((ref) => true);
final obscureConfirmPasswordProvider = StateProvider<bool>((ref) => true);
final isAgreeTermsProvider = StateProvider<bool>((ref) => false);


//Forgot Password Screen
final forgotEmailProvider = StateProvider.autoDispose<TextEditingController>((ref) => TextEditingController());



