import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_sky/models/user_model.dart';
import 'package:job_sky/viewmodels/profile/edit_profile.dart';
import 'package:job_sky/widgets/custom_buttons.dart';
import '../../providers/profile_provider.dart';
import '../../viewmodels/home/profile_image_viewmodel.dart';
import '../../widgets/custom_alert.dart';
import '../../widgets/custom_textfield.dart';
import 'external_functions/pick_picture_functions.dart';

class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen( {super.key, required this.data,});

  final UserModel data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final editProfile = EditProfileViewModel();
    final ProfileImageViewModel uploadProfileImageViewModel =
    ProfileImageViewModel();
    final imagePath = ref.watch(editImagePathProvider);
    final userName = ref.watch(editUserNameProvider);
    final email = ref.watch(editEmailProvider);
    final phone = ref.watch(editPhoneNumberProvider);


    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Edit Profile',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Profile Picture
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () async {
                        if (await requestPermission(context) == true) {
                          final picked = await pickImage();
                          if (picked.isNotEmpty) {
                            ref.read(editImagePathProvider.notifier).state = picked;
                            uploadProfileImageViewModel.uploadImage(
                              imagePath: picked,
                              onFailure: () {
                                OneButtonAlert(
                                  context,
                                  'Error!',
                                  'Failed to upload image',
                                      () {
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            );
                            print('✅ Updated image path: $picked');
                          }
                        } else {
                          print('❌ Permission denied or cancelled');
                        }
                      },
                      child:
                      imagePath != ''
                          ? ClipOval(
                        child: Image.file(
                          File(imagePath),
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      )
                          : data.profileImage != ''
                          ? ClipOval(
                        child: Image.memory(
                          base64Decode(
                            data.profileImage!.split(',').last,
                          ),
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      )
                          : CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey[300],
                        child: Icon(
                          Icons.camera_alt,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  //User Name
                  Text(
                    'User Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  CustomTextField(
                    label: 'Enter your name',
                    controller: userName,
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 10),
                  //Email
                  Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  CustomTextField(
                    label: 'Enter your email',
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    isEnabled: false,
                  ),
                  SizedBox(height: 20),
                  //Phone number
                  Text(
                    'Phone Number',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  CustomTextField(
                    label: 'Enter your phone number',
                    controller: phone,
                    keyboardType: TextInputType.phone,
                  ),
                  //Save Button
                  SizedBox(height: 15),
                  CustomButton(
                    buttonName: "Save Changes",
                    onTap: () {
                      editProfile.changeProfile(
                        username: userName.text,
                        phone: phone.text,
                        email: email.text,
                        onSuccess: () {
                          OneButtonAlert(
                            context,
                            'Done!',
                            'Profile updated successfully',
                                () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          );
                        },
                        onFailure: () {
                          OneButtonAlert(
                            context,
                            'Oops!',
                            'Failed to update profile',
                                () {
                              Navigator.pop(context);
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}