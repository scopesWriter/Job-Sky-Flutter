import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_sky/core/theme/app_colors.dart';
import 'package:job_sky/models/user_model.dart';
import 'package:job_sky/viewmodels/home/profile_image_viewmodel.dart';
import 'package:job_sky/viewmodels/profile/change_profile.dart';
import 'package:job_sky/views/home/edit_profile_screen.dart';
import 'package:job_sky/widgets/custom_alert.dart';
import 'package:job_sky/widgets/custom_buttons.dart';
import 'package:job_sky/widgets/custom_textfield.dart';
import '../../providers/profile_provider.dart';
import '../../widgets/custom_switch.dart';
import '../../widgets/drop_down_widget.dart';
import '../settings/setting_screen.dart';
import 'external_functions/pick_picture_functions.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key, required this.data});

  final UserModel data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ChangeProfileViewModel saveChangeProfileViewModel =
        ChangeProfileViewModel();
    final isPublic = ref.watch(isPublicProvider);
    final isLookingAndKnowJob = ref.watch(isLookingAndKnowJobProvider);
    final isUnDegree = ref.watch(isUnDegreeProvider);
    final location = ref.watch(locationProvider);
    final jobs = ref.watch(jobsProvider);
    final imagePath = ref.watch(imagePathProvider);
    final ProfileImageViewModel uploadProfileImageViewModel =
        ProfileImageViewModel();
    final distance = ref.watch(selectedDistanceProvider);

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //Top Bar Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          ref.read(editUserNameProvider.notifier).state = TextEditingController(text: data.userName);
                          ref.read(editPhoneNumberProvider.notifier).state = TextEditingController(text: data.phoneNumber);
                          ref.read(editEmailProvider.notifier).state = TextEditingController(text: data.email);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfileScreen(data: data,),
                            ),
                          );
                        },
                        icon: Icon(Icons.edit_outlined),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingScreen(),
                            ),
                          );
                        },
                        icon: Icon(Icons.settings_outlined),
                      ),
                    ],
                  ),
                  //Profile Picture
                  GestureDetector(
                    onTap: () async {
                      if (await requestPermission(context) == true) {
                        final picked = await pickImage();
                        if (picked.isNotEmpty) {
                          ref.read(imagePathProvider.notifier).state = picked;
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
                  SizedBox(height: 15),
                  //UserName Text
                  Text(
                    data.userName,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  //Make Public Switch
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'Make ProfilePublic',
                        style: TextStyle(fontSize: 16),
                      ),
                      Spacer(),
                      CustomSwitch(
                        switchValue: isPublic,
                        provider: isPublicProvider,
                      ),
                    ],
                  ),
                  //Only Looking for Job Switch
                  Row(
                    children: [
                      Text(
                        isLookingAndKnowJob
                            ? 'I\'m looking for Job and know the job'
                            : 'I\'m only looking for Job',
                        style: TextStyle(fontSize: 16),
                      ),
                      Spacer(),
                      CustomSwitch(
                        switchValue: isLookingAndKnowJob,
                        provider: isLookingAndKnowJobProvider,
                      ),
                    ],
                  ),
                  //Checkbox Degree
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Checkbox(
                        activeColor: AppColors.authButtonColor,
                        checkColor: Colors.white,
                        value: isUnDegree,
                        onChanged: (isUnDegree) {
                          ref.read(isUnDegreeProvider.notifier).state =
                              isUnDegree!;
                          print('isUnDegree: $isUnDegree');
                        },
                      ),
                      Text(
                        'I Need a job that dosen\'t require a degree',
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColors.textFieldForegroundColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.53,
                        child: CustomTextField(
                          label: 'Location',
                          controller: location,
                        ),
                      ),
                      Spacer(),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.grey[100],
                          ),
                          alignment:  Alignment.center,
                          child: DistanceDropdown())
                    ],
                  ),
                  SizedBox(height: 10),
                  CustomTextField(label: 'Jobs', controller: jobs),
                  SizedBox(height: 30),
                  //Save Button
                  CustomButton(
                    backgroundColor: Colors.transparent,
                    buttonName: 'Save Changes',
                    onTap: () {
                      saveChangeProfileViewModel.changeProfile(
                        isPublic: isPublic,
                        isLookingAndKnowJob: isLookingAndKnowJob,
                        isUnDegree: isUnDegree,
                        location: location.text,
                        jobs: jobs.text,
                        distance: distance,
                        onSuccess: () {
                          OneButtonAlert(
                            context,
                            'Success!',
                            'Profile updated successfully',
                            () {
                              Navigator.pop(context);
                            },
                          );
                        },
                        onFailure: () {
                          OneButtonAlert(
                            context,
                            'Error!',
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
