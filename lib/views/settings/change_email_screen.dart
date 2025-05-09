import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_sky/viewmodels/settings/change_email.dart';
import 'package:job_sky/widgets/custom_alert.dart';
import 'package:job_sky/widgets/loading.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/setting_provider.dart';
import '../../widgets/custom_buttons.dart';
import '../../widgets/custom_textfield.dart';

class ChangeEmailScreen extends ConsumerWidget {
  const ChangeEmailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final changeEmailViewModel = ChangeEmailViewmodel();
    final message =
        'Time for an email makeover! Whether you\'re ditching that old embarrassing address from high school or just switching things up, we\'ve got you covered.';
    final email = ref.watch(newEmailProvider);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus(); // Dismisses keyboard
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Change Email",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(message, style: TextStyle(color: Color(0xFF9E9E9E))),
                  const Text(
                    'New E-mail',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 5),
                  CustomTextField(
                    label: "Enter your new email",
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 15),
                  CustomButton(
                    buttonName: 'Change Email',
                    backgroundColor: AppColors.authButtonColor,
                    foregroundColor: Colors.white,
                    onTap: () {
                      if (email.text.isEmpty ) {
                        OneButtonAlert(
                          context,
                          'Oops!',
                          "Please enter your email ",
                          () {
                            Navigator.pop(context);
                          },
                        );
                        return;
                      }
                      showLoading(context);
                      changeEmailViewModel.changeEmail(
                        newEmail: email.text,
                        onSuccess: () {
                          endLoading(context);
                          // OneButtonAlert(
                          //   context,
                          //   'Done!',
                          //   "Your Email has been changed ",
                          //   () {
                          //     Navigator.pop(context);
                          //     Navigator.pop(context);
                          //   },
                          // );
                        },
                        onFailure: () {
                          endLoading(context);
                          OneButtonAlert(
                            context,
                            'Oops!',
                            "Something went wrong",
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
