import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_sky/viewmodels/auth/forgot_password_viewmodel.dart';
import 'package:job_sky/views/Auth/welcome_screen.dart';
import 'package:job_sky/widgets/custom_alert.dart';
import 'package:job_sky/widgets/loading.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_buttons.dart';
import '../../widgets/custom_textfield.dart';

class ResetPasswordScreen extends ConsumerWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ForgotViewModel forgotViewModel = ForgotViewModel();
    final email = ref.watch(forgotEmailProvider);

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus(); // Dismisses keyboard
      },
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent,systemOverlayStyle: SystemUiOverlayStyle.dark,),

        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Forgot Password',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'To reset your password, enter the e-mail adress you use to sign in',
                    style: TextStyle(color: Color(0xFF9E9E9E)),
                  ),
                  const Text(
                    'E-mail',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 5),
                  CustomTextField(
                    label: "Enter your email",
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 15),
                  CustomButton(
                    buttonName: 'Send',
                    backgroundColor: AppColors.authButtonColor,
                    foregroundColor: Colors.white,
                    onTap: () {
                      showLoading(context);
                      forgotViewModel.ForgotPassword(
                        email: email.text,
                        onSuccess: () {
                          Navigator.pop(context);
                          OneButtonAlert(
                            context,
                            'Done!',
                            'If this email exists, a reset link has been sent.',
                            () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WelcomePage(),
                                ),
                                (route) => false,
                              );
                            },
                          );
                        },
                        onFailure: () {
                          Navigator.pop(context);
                          OneButtonAlert(context, 'Error!', 'Email not found', (){
                            Navigator.pop(context);
                          });
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
