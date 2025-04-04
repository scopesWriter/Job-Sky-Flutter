import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonName,
    required this.onTap,
    this.forgroundColor = Colors.black,
    this.backgroundColor = const Color(0xFFEEEEEE)
  });


  final String buttonName;
  final void Function()? onTap;
  final Color backgroundColor ;
  final Color forgroundColor ;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 15),
        width: 400,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15)
        ),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            splashFactory: NoSplash.splashFactory,
            elevation: 0,
          ),
          child: Text(
            buttonName,
            style: TextStyle(
              color: forgroundColor,
              fontSize: 18
          ),
          )),
      ),
    );
  }
}