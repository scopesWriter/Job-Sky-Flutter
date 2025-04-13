import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_sky/providers/auth_provider.dart';
import 'package:job_sky/widgets/custom_textfield.dart';
import '../../core/theme/app_colors.dart';
import '../../viewmodels/auth/sign_up_viewmodel.dart';
import '../../widgets/custom_alert.dart';
import '../../widgets/custom_buttons.dart';
import '../../widgets/loading.dart';
import '../home/bottom_nav_bar.dart';
import 'login_screen.dart';

class SignupScreen extends ConsumerWidget {
  SignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SignUpViewModel signUpViewModel = SignUpViewModel();
    ;

    final isPasswordSecure = ref.watch(obscurePasswordProvider);
    final isConfirmPasswordSecure = ref.watch(obscureConfirmPasswordProvider);
    final userName = ref.watch(userNameProvider);
    final email = ref.watch(emailProvider);
    final phoneNumber = ref.watch(phoneNumberProvider);
    final password = ref.watch(passwordProvider);
    final confirmPassword = ref.watch(confirmPasswordProvider);
    final isAgreeTerms = ref.watch(isAgreeTermsProvider);

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus(); // Dismisses keyboard
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          title: Text(
            'Create New Account',
            style: TextStyle(color: Colors.white),
          ),
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
                    //Create Account Text
                    const Text(
                      'Create New Account',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    //User Name
                    const Text(
                      'User Name',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 5),
                    CustomTextField(
                      label: "Enter your userName",
                      controller: userName,
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(height: 10),
                    //Email
                    const Text(
                      'E-mail',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 5),
                    CustomTextField(
                      label: "Enter your e-mail",
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 10),
                    //Phone Number
                    const Text(
                      'Phone Number',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 5),
                    CustomTextField(
                      label: "Enter your phone number",
                      controller: phoneNumber,
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 10),
                    //Password
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
                      isSecured: isPasswordSecure,
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordSecure
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Color(0xFF9E9E9E),
                        ),
                        onPressed: () {
                          ref.read(obscurePasswordProvider.notifier).state =
                              !isPasswordSecure;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    //Confirm Password
                    const Text(
                      'Confirm password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 5),
                    CustomTextField(
                      label: "Enter your password again",
                      controller: confirmPassword,
                      keyboardType: TextInputType.visiblePassword,
                      isSecured: isConfirmPasswordSecure,
                      suffixIcon: IconButton(
                        icon: Icon(
                          isConfirmPasswordSecure
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Color(0xFF9E9E9E),
                        ),
                        onPressed: () {
                          ref
                              .read(obscureConfirmPasswordProvider.notifier)
                              .state = !isConfirmPasswordSecure;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    //Agree Terms
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Checkbox(
                            activeColor: AppColors.authButtonColor,
                            checkColor: Colors.white,
                            value: isAgreeTerms,
                            onChanged: (isAgreeTerms) {
                              ref.read(isAgreeTermsProvider.notifier).state =
                                  isAgreeTerms!;
                              print('isAgreeTerms: $isAgreeTerms');
                            },
                          ),
                          Text(
                            'By signing up, you agree to our terms\n of service and privacy policy.',
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.textFieldForegroundColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    CustomButton(
                      buttonName: 'Sign Up',
                      backgroundColor: AppColors.authButtonColor,
                      foregroundColor: Colors.white,
                      onTap: () {
                        if (userName.text.isEmpty ||
                            email.text.isEmpty ||
                            phoneNumber.text.isEmpty ||
                            password.text.isEmpty ||
                            confirmPassword.text.isEmpty) {
                          OneButtonAlert(
                            context,
                            "Oops!",
                            "Please fill all the fields",
                            () {
                              Navigator.pop(context);
                            },
                          );
                          return;
                        }
                        if (!isAgreeTerms) {
                          // Show an error message
                          OneButtonAlert(
                            context,
                            'Error',
                            'Please agree to the terms of service and privacy policy.',
                            () {
                              Navigator.pop(context);
                            },
                          );
                          return;
                        }
                        if (password.text != confirmPassword.text) {
                          // Show an error message
                          OneButtonAlert(
                            context,
                            'Error',
                            'Passwords do not match.',
                            () {
                              Navigator.pop(context);
                            },
                          );
                          return;
                        }
                        showLoading(context);
                        signUpViewModel.signUp(
                          email: email.text,
                          password: password.text,
                          username: userName.text,
                          phone: phoneNumber.text,
                          onSuccess: () {
                            endLoading(context);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BottomNavBar(),
                              ),
                              (route) => false,
                            );
                          },
                          onFailure: () {
                            endLoading(context);
                            OneButtonAlert(
                              context,
                              'Error',
                              'Sign up failed.',
                              () {
                                Navigator.pop(context);
                              },
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    CustomButton(
                      buttonName: 'Already have an account? Sign In',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
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
