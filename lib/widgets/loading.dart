import 'package:flutter/material.dart';

Future<void> ShowLoading(BuildContext context) async {
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

Future<void> EndLoadin(BuildContext context) async {
  Navigator.of(context).pop(); // Dismiss the loading indicator
}


