import 'package:flutter/material.dart';
import 'package:job_sky/core/theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.suffixIcon,
    this.isSecured = false,
    this.keyboardType = TextInputType.text,
    this.backgroundColor = AppColors.textFieldBackgroundColor,
    this.foregroundColor = AppColors.textFieldForegroundColor,
    this.maxLines = 1,
    this.minLines = 1,
    this.isEnabled = true
  });

  final TextEditingController controller;
  final String label;
  final Widget? suffixIcon;
  final bool isSecured;
  final TextInputType keyboardType;
  final Color backgroundColor ;
  final Color foregroundColor ;
  final int maxLines;
  final int minLines;
  final bool isEnabled;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //Validate Emails and Phone Numbers , Password
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          if (keyboardType == TextInputType.text) {
            return null;
          }
          return 'Please enter your value';
        }

        if (keyboardType == TextInputType.emailAddress) {
          final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
          if (!emailRegex.hasMatch(value)) {
            return 'Please enter a valid email address';
          }
        } else if (keyboardType == TextInputType.phone) {
          final phoneRegex = RegExp(r'^\+?\d{7,15}$');
          if (!phoneRegex.hasMatch(value)) {
            return 'Please enter a valid phone number';
          }
        } else if (keyboardType == TextInputType.visiblePassword) {
          final passwordRegex = RegExp(
              r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
          if (!passwordRegex.hasMatch(value)) {
            return 'Password must be at least 8 characters,\ninclude uppercase, lowercase, number & special char';
          }
        }

        return null;
      },

      enabled: isEnabled,
      maxLines: maxLines,
      minLines: minLines,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor: Colors.black,
      controller: controller,
      obscureText: isSecured,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: backgroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        hintText: label,
        suffixIcon: suffixIcon,
        hintStyle: TextStyle(color: foregroundColor),
      ),
    );
  }
}
