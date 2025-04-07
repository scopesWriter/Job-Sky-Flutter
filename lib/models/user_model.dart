

class UserModel {
  final String uid;
  final String userName;
  final String email;
  final String phoneNumber;
  final String password;

  UserModel({required this.uid,required this.userName,required this.email,required this.phoneNumber, required this.password});

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'],
      userName: data['name'],
      email: data['email'],
      phoneNumber: data['phoneNumber'],
      password: data['password'],
    );
  }

}