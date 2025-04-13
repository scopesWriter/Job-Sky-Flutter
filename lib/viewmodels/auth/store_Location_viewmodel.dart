import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/firebase_auth_service/auth/store_location.dart';

class StoreLocationViewmodel extends ChangeNotifier {
  final GetLocationService getLocation = GetLocationService();

  Future<void> storeUserLocation({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    try {
      await getLocation.storeUserLocation(context: context, ref: ref);
    } catch(e) {
      print('Error: $e');
    }

  }
}
