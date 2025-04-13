import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import '../../../providers/home_provider.dart';
import '../../external_function/get_location.dart';

class GetLocationService {
  Future<void> storeUserLocation( {required BuildContext context, required WidgetRef ref }) async {
    final getLocation = GetLocation();
    Position position = await getLocation.getCurrentLocation(context: context);
    double lat = position.latitude;
    double lng = position.longitude;
    ref.read(currentLatProvider.notifier).state = lat;
    ref.read(currentLngProvider.notifier).state = lng;

    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance.collection('users').doc(currentUserId).update({
      'userlocation': {'lat': lat, 'lng': lng},
    });

    print('✅ Location stored successfully.');
  }
}
