import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

Future<void> showLoading(BuildContext context) async {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent closing by tapping outside
    builder: (BuildContext context) {
      return Center(
        child: CircularProgressIndicator(
          color: AppColors.loadingColor,
        ),
      );
    },
  );

}

Future<void> endLoading(BuildContext context) async {
  Navigator.of(context).pop(); // Dismiss the loading indicator
}


