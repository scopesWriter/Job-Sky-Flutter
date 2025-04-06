import 'package:flutter/material.dart';

Future<bool> showMyAlert(BuildContext context) async {
  final title = 'Permission Denied';
  final text = 'Please grant permission to access the gallery from settings.';

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
