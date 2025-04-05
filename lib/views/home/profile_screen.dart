import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_sky/core/theme/app_colors.dart';
import 'package:job_sky/widgets/custom_buttons.dart';
import 'package:job_sky/widgets/custom_textfield.dart';

import '../../providers/home_provider.dart';
import '../settings/setting_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final isPublic = ref.watch(isPublicProvider);
    final isOnlyForJob = ref.watch(isOnlyForJobProvider);
    final isUnDegree = ref.watch(isUnDegreeProvider);
    final location = ref.watch(locationProvider);
    final jobs = ref.watch(jobsProvider);

    return GestureDetector(
      // Dismisses keyboard
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SingleChildScrollView(child: Column(
              children: [
                //Top Bar Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                    IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SettingScreen()));
                    },
                    icon: Icon(Icons.settings)),
                  ],
                ),
                //Profile Picture
                GestureDetector(
                  onTap: () {
                    print('Image tapped');
                  },
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/no_image.png'),
                    radius: 50,
                  ),
                ),
                SizedBox(height: 15),
                //UserName Text
                Text(
                  'UserName',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                //Make Public Switch
                SizedBox(height: 10),
                Row(
                  children: [
                    Text('Make ProfilePublic', style: TextStyle(fontSize: 18)),
                    Spacer(),
                    Switch(
                      activeTrackColor: AppColors.authButtonColor,
                      inactiveTrackColor: AppColors.textFieldBackgroundColor,
                      inactiveThumbColor: Colors.grey,
                      trackOutlineColor: WidgetStatePropertyAll(
                        Colors.transparent,
                      ),
                      value: isPublic,
                      onChanged: (isPublic) {
                        ref.read(isPublicProvider.notifier).state = isPublic;
                        print('isPublic: $isPublic');
                      },
                    ),
                  ],
                ),
                //Only Looking for Job Switch
                Row(
                  children: [
                    Text(
                      'I\'m only looking for Job',
                      style: TextStyle(fontSize: 18),
                    ),
                    Spacer(),
                    Switch(
                      activeTrackColor: AppColors.authButtonColor,
                      inactiveTrackColor: AppColors.textFieldBackgroundColor,
                      inactiveThumbColor: Colors.grey,
                      trackOutlineColor: WidgetStatePropertyAll(
                        Colors.transparent,
                      ),
                      value: isOnlyForJob,
                      onChanged: (isOnlyForJob) {
                        ref.read(isOnlyForJobProvider.notifier).state =
                            isOnlyForJob;
                        print('isOnlyForJob: $isOnlyForJob');
                      },
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
                        ref.read(isUnDegreeProvider.notifier).state = isUnDegree!;
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
                CustomTextField(label: 'Location', controller: location),
                SizedBox(height: 10),
                CustomTextField(label: 'Jobs', controller: jobs),
                SizedBox(height: 30,),
                //Save Button
                CustomButton(buttonName: 'Save Changes', onTap: () {
                  print('isPublic: $isPublic');
                  print('isOnlyForJob: $isOnlyForJob');
                  print('isUnDegree: $isUnDegree');
                  print('location: ${location.text}');
                  print('jobs: ${jobs.text}');
                })
              ],
            ),
            )
          ),
        ),
      ),
    );
  }
}
