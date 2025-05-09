class UserModel {
  final String uid;
  final String email;
  final String userName;
  final String phoneNumber;
  final String? profileImage;
  final bool isPublic ;
  final bool isLookingAndKnowJob ;
  final bool isUnDegree ;
  final String location ;
  final String jobs ;
  final String distance;
  final double lat;
  final double lng;
  final List<String> followers;
  final List<String> following;
  final List<int> rates;

  UserModel({
    required this.uid,
    required this.email,
    required this.userName,
    required this.phoneNumber,
    this.profileImage,
    this.isPublic = false,
    this.isLookingAndKnowJob = false,
    this.isUnDegree = false,
    this.location = '',
    this.jobs = '',
    this.distance = '10 miles',
    this.lat = 0.0,
    this.lng = 0.0,
    this.followers = const [],
    this.following = const [],
    this.rates = const [],
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? 'Unknown',
      userName: map['username'] ?? 'Unknown',
      phoneNumber: map['phone'] ?? 'Unknown',
      profileImage: map['profile_image'] ?? '',
      isPublic: map['isPublic'] ?? false,
      isLookingAndKnowJob: map['isLookingAndKnowJob'] ?? false,
      isUnDegree: map['isUnDegree'] ?? false,
      location: map['location'] ?? '',
      jobs: map['jobs'] ?? '',
      distance: map['distance'] ?? '',
      lat: (map['lat'] as num?)?.toDouble() ?? 0.0,
      lng: (map['lng'] as num?)?.toDouble() ?? 0.0,
      followers: List<String>.from(map['followers'] ?? []),
      following: List<String>.from(map['following'] ?? []),
      rates: List<int>.from(map['rates'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'username': userName,
      'phone': phoneNumber,
      'profile_image': profileImage,
      'isPublic': isPublic,
      'isLookingAndKnowJob': isLookingAndKnowJob,
      'isUnDegree': isUnDegree,
      'location': location,
      'jobs': jobs,
      'distance': distance,
      'lat': lat,
      'lng': lng,
      'followers': followers,
      'following': following,
      'rates': rates
    };
  }
}
