import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_buttons.dart';
import '../../widgets/custom_textfield.dart';

class ResetPasswordScreen extends ConsumerWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final email = ref.watch(forgotEmailProvider);

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus(); // Dismisses keyboard
      },
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Forgot Password',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'To reset your password, enter the e-mail adress you use to sign in',
                    style: TextStyle(color: Color(0xFF9E9E9E)),
                  ),
                  const Text(
                    'E-mail',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 5),
                  CustomTextField(
                    label: "Enter your email",
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 15),
                  CustomButton(
                    buttonName: 'Send code',
                    backgroundColor: AppColors.authButtonColor,
                    foregroundColor: Colors.white,
                    onTap: () {
                      print('email is: ${email.text}');
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
