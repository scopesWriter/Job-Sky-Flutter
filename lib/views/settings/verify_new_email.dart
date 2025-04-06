import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/setting_provider.dart';
import '../../widgets/custom_buttons.dart';

class VerifyNewEmail extends ConsumerWidget {
  VerifyNewEmail({super.key});

  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  String get otp => _controllers.map((controller) => controller.text).join();

  Widget build(BuildContext context, WidgetRef ref) {
    final message =
        'We\'ve sent a code to the email address you entered. Please enter the code below to verify your email address.';
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus(); // Dismisses keyboard
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Verify your Email",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: SafeArea(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(message, style: TextStyle(color: Color(0xFF9E9E9E))),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(6, (index) {
                        return Container(
                          width: 45,
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          child: TextField(
                            cursorColor: Colors.black,
                            controller: _controllers[index],
                            focusNode: _focusNodes[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            onChanged: (value) => _onChanged(value, index),
                            decoration: InputDecoration(
                              fillColor: AppColors.textFieldBackgroundColor,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              counterText: "", // hide counter
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 15),
                    CustomButton(
                      buttonName: 'Send code',
                      backgroundColor: AppColors.authButtonColor,
                      foregroundColor: Colors.white,
                      onTap: () {
                        print("Entered OTP: $otp");
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
