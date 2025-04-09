import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:job_sky/models/user_model.dart';
import 'package:job_sky/views/auth/external_functions/uid_functions.dart';

class ProfileImageService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> compressAndUploadImage(String filePath) async {
    final userId = await getUid();
    final result = await FlutterImageCompress.compressWithFile(
      filePath,
      minWidth: 800,
      minHeight: 800,
      quality: 80,
    );

    if (result != null) {

      String base64Image = base64Encode(result);
      print('✅ try to Updload image path: $base64Image.');
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'profile_image': base64Image});
      print('✅ Uploaded image path: $base64Image');
    } else {
      print('Image compression failed');
    }
  }

  Future<UserModel> getProfileData() async {
    try {
      final userId = await getUid();
      final doc = await firestore.collection('users').doc(userId).get();
      final data = doc.data();

      if (data != null ) {
        print('Profile data retrieved successfully.');
        return  UserModel.fromMap(data);
      } else {
        print('No profile data found for this user.');
        return UserModel(uid: '', email: '', userName: '', phoneNumber: '', profileImage: '');
      }
    } catch (e) {
      print("Error retrieving data: $e");
      return UserModel(uid: '', email: '', userName: '', phoneNumber: '', profileImage: '');
    }
  }
}
