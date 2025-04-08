import 'package:flutter/material.dart';

Future<bool> TwoButtonsAlert(BuildContext context, String title, String text ) async {

  final result = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        alignment: Alignment.center,
        title: Text(title, textAlign: TextAlign.center),
        content: Text(text, textAlign: TextAlign.center),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Ok', style: TextStyle(color: Colors.black)),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Cancel', style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ],
      );
    },
  );
  return result ?? false;
}


//One Button
Future<bool> OneButtonAlert(BuildContext context, String title, String text , VoidCallback onPress) async {

  final result = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        alignment: Alignment.center,
        title: Text(title, textAlign: TextAlign.center),
        content: Text(text, textAlign: TextAlign.center),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: onPress,
                child: Text('Ok', style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ],
      );
    },
  );
  return result ?? false;
}
