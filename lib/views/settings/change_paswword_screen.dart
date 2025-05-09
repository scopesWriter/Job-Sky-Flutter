import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_sky/widgets/custom_alert.dart';
import 'package:job_sky/widgets/loading.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/setting_provider.dart';
import '../../viewmodels/settings/change_password_viewmodel.dart';
import '../../widgets/custom_buttons.dart';
import '../../widgets/custom_textfield.dart';

class ChangePasswordScreen extends ConsumerWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final changePasswordViewModel = ChangePasswordViewmodel();

    final message =
        'Time to change your password! Make it strong enough to keep out your nosy neighbours, but easy enough to remember after your morning coffee.';

    final oldPassword = ref.watch(oldPasswordProvider);
    final newPassword = ref.watch(newPasswordProvider);
    final confirmNewPassword = ref.watch(confirmNewPasswordProvider);
    final isConfirmPasswordSecured = ref.watch(
      obscureConfirmNewPasswordProvider,
    );
    final isNewPasswordSecured = ref.watch(obscureNewPasswordProvider);
    final isOldPasswordSecured = ref.watch(obscureOldPasswordProvider);

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus(); // Dismisses keyboard
      },
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: Colors.transparent,
          title: Text('Change Password', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(message, style: TextStyle(color: Color(0xFF9E9E9E))),
                    //Old Password
                    const Text(
                      'Old password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 5),
                    CustomTextField(
                      label: "Enter your Old password",
                      controller: oldPassword,
                      keyboardType: TextInputType.visiblePassword,
                      isSecured: isOldPasswordSecured,
                      suffixIcon: IconButton(
                        icon: Icon(
                          isOldPasswordSecured
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Color(0xFF9E9E9E),
                        ),
                        onPressed: () {
                          ref.read(obscureOldPasswordProvider.notifier).state =
                              !isOldPasswordSecured;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    //New Password
                    const Text(
                      'New password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 5),
                    CustomTextField(
                      label: "Enter your New password",
                      controller: newPassword,
                      keyboardType: TextInputType.visiblePassword,
                      isSecured: isNewPasswordSecured,
                      suffixIcon: IconButton(
                        icon: Icon(
                          isNewPasswordSecured
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Color(0xFF9E9E9E),
                        ),
                        onPressed: () {
                          ref.read(obscureNewPasswordProvider.notifier).state =
                              !isNewPasswordSecured;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    //Confirm New Password
                    const Text(
                      'Confirm New password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 5),
                    CustomTextField(
                      label: "Enter your new password again",
                      controller: confirmNewPassword,
                      keyboardType: TextInputType.visiblePassword,
                      isSecured: isConfirmPasswordSecured,
                      suffixIcon: IconButton(
                        icon: Icon(
                          isConfirmPasswordSecured
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Color(0xFF9E9E9E),
                        ),
                        onPressed: () {
                          ref
                              .read(obscureConfirmNewPasswordProvider.notifier)
                              .state = !isConfirmPasswordSecured;
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    //Change Password Button
                    CustomButton(
                      buttonName: 'Change Password',
                      backgroundColor: AppColors.authButtonColor,
                      foregroundColor: Colors.white,
                      onTap: () {
                        if (oldPassword.text.isEmpty ||
                            newPassword.text.isEmpty ||
                            confirmNewPassword.text.isEmpty) {
                          OneButtonAlert(
                            context,
                            'Oops!',
                            "All fields are required",
                            () {
                              Navigator.pop(context);
                            });
                          return;
                        }
                        if (oldPassword.text == newPassword.text) {
                          OneButtonAlert(
                            context,
                            'Oops!',
                            "You can't use old Passwords",
                            () {
                              Navigator.pop(context);
                            },
                          );
                          return;
                        }
                        if (newPassword.text != confirmNewPassword.text) {
                          OneButtonAlert(
                            context,
                            'Oops!',
                            "Passwords do not match",
                            () {
                              Navigator.pop(context);
                            },
                          );
                          return;
                        }
                        showLoading(context);
                        changePasswordViewModel.changePassword(
                          newPassword: newPassword.text,
                          oldPassword: oldPassword.text,
                          onSuccess: () {
                            endLoading(context);
                            OneButtonAlert(
                              context,
                              'Done!',
                              "Password changed",
                              () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            );
                          },
                          onFailure: () {
                            endLoading(context);
                            OneButtonAlert(
                              context,
                              'Error!',
                              "an error occurred",
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
      ),
    );
  }
}
