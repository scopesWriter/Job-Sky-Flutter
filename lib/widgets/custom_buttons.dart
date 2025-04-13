import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonName,
    required this.onTap,
    this.foregroundColor = Colors.black,
    this.backgroundColor = AppColors.buttonColor,
    this.borderRadius = 25,
  });

  final String buttonName;
  final void Function()? onTap;
  final Color backgroundColor;
  final Color foregroundColor;
  final double? borderRadius ;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(

        hoverColor: Colors.grey[600],
        hoverDuration: Duration(milliseconds: 1000),
        borderRadius: BorderRadius.circular(borderRadius!),
        onTap: onTap,
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: Colors.grey[100]!, width: 2),
            borderRadius: BorderRadius.circular(borderRadius!),
          ),
          child: Text(
            textAlign: TextAlign.center,
            buttonName,
            style: TextStyle(
                color: foregroundColor,
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}
