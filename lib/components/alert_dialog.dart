import 'package:flutter/material.dart';

import 'dialog.dart';

class CustomDialog {
  static showAlertDialog(
      BuildContext context, String title, String content, String status,
      {dynamic onButtonPressed = 0}) {
    showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
              title: title,
              content: content,
              status: status,
              onButtonPressed: onButtonPressed);
        });
  }
}
