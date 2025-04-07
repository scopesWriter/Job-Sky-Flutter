
import 'package:flutter/material.dart';

class HomeCardButton extends StatelessWidget {
  HomeCardButton({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.onPressed,
  });

  final Color iconColor;

  final IconData icon;

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey[100]!, width: 2),
      ),
      child: InkWell(
        hoverColor: Colors.grey[100],
        hoverDuration: Duration(milliseconds: 1000),
        borderRadius: BorderRadius.circular(50),

        focusColor: Colors.orange,
        onTap: () {
          onPressed!();
        },
        child: SizedBox(
          width: 65,
          height: 65,
          child: Center(
            child: Icon(icon, color: iconColor, size: 40),
          ),
        ),
      ),
    );
  }
}
