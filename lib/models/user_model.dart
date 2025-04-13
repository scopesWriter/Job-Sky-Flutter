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
  final double distance;
  final double lat;
  final double lng;

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
    this.distance = 0.0,
    this.lat = 0.0 ,
    this.lng = 0.0 ,
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
      distance: map['distance'] ?? 0.0,
      lat: map['location']['lat'] ?? 0.0,
      lng: map['location']['lng'] ?? 0.0,
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
      'userlocation': {
        'lat': lat,
        'lng': lng,
      },
    };
  }
}
