import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GetLocation {

  Future<void> handlePermissionDenied(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Location Permission Required'),
        content: Text('We need your location to show nearby users. Please enable location access in your device settings.'),
        actions: <Widget>[
          TextButton(
            child: Text('Open Settings'),
            onPressed: () {
              Geolocator.openLocationSettings();
              Navigator.pop(context); // Close dialog
            },
          ),
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.pop(context); // Close dialog
            },
          ),
        ],
      ),
    );
  }

  Future<Position> getCurrentLocation({required BuildContext context}) async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      handlePermissionDenied(context);
      return Future.error("Location permission denied");
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

}

