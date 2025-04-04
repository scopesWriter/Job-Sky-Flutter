import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_sky/providers/auth_provider.dart';
import 'package:job_sky/views/auth/reset_password_screen.dart';
import 'package:job_sky/widgets/custom_textfield.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/custom_buttons.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isObscured = ref.watch(loginObscurePasswordProvider);
    final email = ref.watch(loginEmailProvider);
    final password = ref.watch(loginPasswordProvider);

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus(); // Dismisses keyboard
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Login to JobSky', style: TextStyle(color: Colors.white)),
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
                    //Screen Title
                    const Text(
                      'Login to JobSky',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 90),
                    //Email Section
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
                    SizedBox(height: 10),
                    //Password Section
                    const Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 5),
                    CustomTextField(
                      label: "Enter your password",
                      controller: password,
                      keyboardType: TextInputType.visiblePassword,
                      isSecured: isObscured,
                      suffixIcon: IconButton(
                        icon: Icon(
                          isObscured ? Icons.visibility_off : Icons.visibility,
                          color: Color(0xFF9E9E9E),
                        ),
                        onPressed: () {
                          ref
                              .read(loginObscurePasswordProvider.notifier)
                              .state = !isObscured;
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    //Login Button
                    CustomButton(
                      buttonName: 'Login',
                      backgroundColor: AppColors.authButtonColor,
                      foregroundColor: Colors.white,
                      onTap: () {
                        print('email is: ${email.text}');
                        print('password is: ${password.text}');
                      },
                    ),
                    //Forget Password Button
                    CustomButton(
                      buttonName: 'Forgot password?',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResetPasswordScreen(),
                          ),
                        );
                      },
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.black,
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
