
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Bottom Navigation
final bottomIndexProvider = StateProvider<int>((ref) => 0); //index


//Profile Screen
final isPublicProvider = StateProvider<bool>((ref) => false);
final isOnlyForJobProvider = StateProvider<bool>((ref) => false);
final isUnDegreeProvider = StateProvider<bool>((ref) => false);
final locationProvider = StateProvider<TextEditingController>((ref) => TextEditingController());
final jobsProvider = StateProvider<TextEditingController>((ref) => TextEditingController());