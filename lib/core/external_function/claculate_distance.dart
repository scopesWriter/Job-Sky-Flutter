import 'dart:math';

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const radius = 6371; // Radius of the Earth in km
  final dLat = (lat2 - lat1) * pi / 180;
  final dLon = (lon2 - lon1) * pi / 180;

  final a = sin(dLat / 2) * sin(dLat / 2) +
      cos(lat1 * pi / 180) * cos(lat2 * pi / 180) *
          sin(dLon / 2) * sin(dLon / 2);

  final c = 2 * atan2(sqrt(a), sqrt(1 - a));
  final distanceInKm = radius * c; // Distance in km

  // Convert km to miles
  return distanceInKm * 0.621371;
}
