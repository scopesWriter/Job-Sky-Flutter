//Edit Profile Screen
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profilePicPathProvider = StateProvider<String>((ref) => '');

//Profile Screen
final isPublicProvider = StateProvider<bool>((ref) => false);
final isLookingAndKnowJobProvider = StateProvider<bool>((ref) => false);
final isUnDegreeProvider = StateProvider<bool>((ref) => false);
final locationProvider = StateProvider<TextEditingController>((ref) => TextEditingController());
final jobsProvider = StateProvider<TextEditingController>((ref) => TextEditingController());
final imagePathProvider = StateProvider<String>((ref) => '');
final selectedDistanceProvider = StateProvider<String>((ref) => '10 miles');

