import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_sky/core/theme/app_colors.dart';
import 'package:job_sky/models/user_model.dart';
import 'package:job_sky/providers/home_provider.dart';
import 'package:job_sky/viewmodels/profile/change_profile.dart';
import 'package:job_sky/views/home/edit_profile_screen.dart';
import 'package:job_sky/widgets/custom_alert.dart';
import 'package:job_sky/widgets/custom_buttons.dart';
import 'package:job_sky/widgets/custom_textfield.dart';
import '../../providers/profile_provider.dart';
import '../../viewmodels/home/profile_image_viewmodel.dart';
import '../../viewmodels/profile/friend_follow.dart';
import '../../widgets/custom_switch.dart';
import '../../widgets/drop_down_widget.dart';
import '../../widgets/loading.dart';
import '../settings/setting_screen.dart';
import 'external_functions/following_screen_data.dart';
import 'external_functions/pick_picture_functions.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();

  static route() => MaterialPageRoute(builder: (context) => ProfileScreen());
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  UserModel data = UserModel(
    uid: '',
    email: '',
    userName: '',
    phoneNumber: '',
    profileImage: '',
  );

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      try {
        // Fetch user data from the provider
        final user = await ref.read(dataProfileProvider.future);

        // Update the local `data` variable
        setState(() {
          data = user;
        });

        // Delay provider updates to avoid modifying during build
        Future(() {
          ref
              .read(isPublicProvider.notifier)
              .state = user.isPublic;
          ref
              .read(selectedDistanceProvider.notifier)
              .state = user.distance;
          ref
              .read(isLookingAndKnowJobProvider.notifier)
              .state =
              user.isLookingAndKnowJob;
          ref
              .read(isUnDegreeProvider.notifier)
              .state = user.isUnDegree;
          ref
              .read(locationProvider.notifier)
              .state = TextEditingController(
            text: user.location,
          );
          ref
              .read(jobsProvider.notifier)
              .state = TextEditingController(
            text: user.jobs,
          );
        });
      } catch (e) {
        debugPrint('Error fetching user data: $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(dataProfileProvider);
    final imagePath = ref.watch(imagePathProvider);

    return data.when(
      data: (data) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Top Bar Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              ref
                                  .read(editUserNameProvider.notifier)
                                  .state =
                                  TextEditingController(text: data.userName);
                              ref
                                  .read(editPhoneNumberProvider.notifier)
                                  .state =
                                  TextEditingController(text: data.phoneNumber);
                              ref
                                  .read(editEmailProvider.notifier)
                                  .state =
                                  TextEditingController(text: data.email);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                      EditProfileScreen(data: data),
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit_outlined),
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
                            icon: const Icon(Icons.settings_outlined),
                          ),
                        ],
                      ),

                      // Profile Picture
                      GestureDetector(
                        onTap: () async {
                          if (await requestPermission(context) == true) {
                            final picked = await pickImage();
                            if (picked.isNotEmpty) {
                              ref.read(imagePathProvider.notifier).state = picked;
                              ProfileImageViewModel().uploadImage(
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
                      const SizedBox(height: 15),

                      // UserName Text
                      Text(
                        data.userName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // Make Public Switch
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomButton(
                            buttonName: 'Followers',
                            onTap: () async {
                              showLoading(context);
                              List<UserModel> followers = [];
                              final users =
                              await FriendsListViewModel().getUserStream();
                              for (final follower in data.followers) {
                                for (final user in users) {
                                  if (follower == user.uid) {
                                    followers.add(user);
                                  }
                                }
                              }
                              endLoading(context);
                              showUsersList(context, followers, ref);
                            },
                            halfWidth: true,
                            backgroundColor: AppColors.authButtonColor,
                            foregroundColor: Colors.white,
                          ),
                          CustomButton(
                            buttonName: 'Following',
                            onTap: () async {
                              showLoading(context);
                              List<UserModel> following = [];
                              final users =
                              await FriendsListViewModel().getUserStream();
                              for (final follow in data.following) {
                                for (final user in users) {
                                  if (follow == user.uid) {
                                    following.add(user);
                                  }
                                }
                              }
                              endLoading(context);
                              showUsersList(context, following, ref);
                            },
                            halfWidth: true,
                            backgroundColor: AppColors.authButtonColor,
                            foregroundColor: Colors.white,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Make Profile Public',
                            style: TextStyle(fontSize: 16),
                          ),
                          const Spacer(),
                          Consumer(
                            builder: (context, ref, _) {
                              final isPublic = ref.watch(isPublicProvider);
                              return CustomSwitch(
                                switchValue: isPublic,
                                provider: isPublicProvider,
                              );
                            },
                          ),
                        ],
                      ),
                      // Only Looking for Job Switch
                      Row(
                        children: [
                          Consumer(
                            builder: (context, ref, _) {
                              final isLookingAndKnowJob = ref.watch(
                                isLookingAndKnowJobProvider,
                              );
                              return Text(
                                isLookingAndKnowJob
                                    ? 'I\'m looking for Job and know the job'
                                    : 'I\'m only looking for Job',
                                style: const TextStyle(fontSize: 16),
                              );
                            },
                          ),
                          const Spacer(),
                          Consumer(
                            builder: (context, ref, _) {
                              final isLookingAndKnowJob = ref.watch(
                                isLookingAndKnowJobProvider,
                              );
                              return CustomSwitch(
                                switchValue: isLookingAndKnowJob,
                                provider: isLookingAndKnowJobProvider,
                              );
                            },
                          ),
                        ],
                      ),
                      // Checkbox Degree
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Consumer(
                            builder: (context, ref, _) {
                              final isUnDegree = ref.watch(isUnDegreeProvider);
                              return Checkbox(
                                activeColor: AppColors.authButtonColor,
                                checkColor: Colors.white,
                                value: isUnDegree,
                                onChanged: (value) {
                                  ref
                                      .read(isUnDegreeProvider.notifier)
                                      .state =
                                  value!;
                                },
                              );
                            },
                          ),
                          const Text(
                            'I Need a job that doesn\'t require a degree',
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.textFieldForegroundColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.53,
                            child: Consumer(
                              builder: (context, ref, _) {
                                final locationController = ref.watch(
                                  locationProvider,
                                );
                                return CustomTextField(
                                  label: 'Location',
                                  controller: locationController,
                                );
                              },
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.35,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.grey[100],
                            ),
                            alignment: Alignment.center,
                            child: const DistanceDropdown(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Consumer(
                        builder: (context, ref, _) {
                          final jobsController = ref.watch(jobsProvider);
                          return CustomTextField(
                            label: 'Jobs',
                            controller: jobsController,
                          );
                        },
                      ),
                      const SizedBox(height: 30),
                      // Save Button
                      CustomButton(
                        backgroundColor: Colors.transparent,
                        buttonName: 'Save Changes',
                        onTap: () {
                          final isPublic = ref.read(isPublicProvider);
                          final isLookingAndKnowJob = ref.read(
                            isLookingAndKnowJobProvider,
                          );
                          final isUnDegree = ref.read(isUnDegreeProvider);
                          final locationController = ref.read(locationProvider);
                          final jobsController = ref.read(jobsProvider);
                          final distance = ref.read(selectedDistanceProvider);

                          ChangeProfileViewModel().changeProfile(
                            isPublic: isPublic,
                            isLookingAndKnowJob: isLookingAndKnowJob,
                            isUnDegree: isUnDegree,
                            location: locationController.text,
                            jobs: jobsController.text,
                            distance: distance,
                            onSuccess: () {
                              OneButtonAlert(
                                context,
                                'Success!',
                                'Profile updated successfully',
                                    () {
                                  ref.invalidate(dataProfileProvider);
                                  ref.read(cardsProvider.notifier).state = [];
                                  ref.invalidate(cardsDataProvider);
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
      },
      error: (error, stackTrace) => Text('Error: $error'),
      loading: () =>  Center(child: CircularProgressIndicator(color: AppColors.loadingColor,)),
    );
  }
}
