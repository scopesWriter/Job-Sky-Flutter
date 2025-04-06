import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonName,
    required this.onTap,
    this.foregroundColor = Colors.black,
    this.backgroundColor = AppColors.buttonColor,
  });

  final String buttonName;
  final void Function()? onTap;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 50,
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: backgroundColor,
          ),
          child: Text(
            textAlign: TextAlign.center,
            buttonName,
            style: TextStyle(
              color: foregroundColor,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
