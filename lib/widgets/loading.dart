import 'package:flutter/material.dart';

Future<void> showLoading(BuildContext context) async {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent closing by tapping outside
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );

}

Future<void> endLoading(BuildContext context) async {
  Navigator.of(context).pop(); // Dismiss the loading indicator
}


