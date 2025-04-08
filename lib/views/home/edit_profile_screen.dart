import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_sky/widgets/custom_buttons.dart';
import '../../providers/profile_provider.dart';
import '../../widgets/custom_textfield.dart';
import 'external_functions/pick_picture_functions.dart';

class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    final imagePath = ref.watch(profilePicPathProvider);
    final userName = TextEditingController();
    final email = TextEditingController();
    final phone = TextEditingController();

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
                            ref.read(profilePicPathProvider.notifier).state =
                                picked;
                            print('✅ Updated image path: $picked');
                          } else {
                            print('⚠️ No image picked');
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
                      print('user name is: ${userName.text}');
                      print('email is: ${email.text}');
                      print('phone is: ${phone.text}');
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