import 'package:flutter/material.dart';

import 'layout.dart';
import 'txt.dart';

class GlobalMethod {
  static void showErrorDialog({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String body,
    required String buttonText,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            elevation: layout.elevation,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(layout.radius),
            ),
            backgroundColor: Colors.white,
            title: Row(children: [
              Padding(
                padding: const EdgeInsets.all(layout.padding / 2),
                child: Icon(
                  icon,
                  size: layout.iconLarge,
                  color: iconColor,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(layout.padding),
                  child: Text(
                    title,
                    style: txt.titleDark,
                  ),
                ),
              ),
            ]),
            content: Text(
              body,
              style: txt.body2Dark,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: Text(
                  buttonText,
                  style: txt.dialogOptions,
                ),
              ),
            ]);
      },
    );
  }
}

class GlobalMethodTwo {
  static void showErrorDialog(
      {required String error, required BuildContext ctx}) {
    showDialog(
        context: ctx,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.logout,
                    color: Colors.grey,
                    size: 35,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    'Error Occurred ',
                  ),
                ),
              ],
            ),
            content: Text(
              '$error',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontStyle: FontStyle.italic),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          );
        });
  }
}
