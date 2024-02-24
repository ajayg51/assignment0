import 'package:flutter/material.dart';

class CustomDialog {
  static void showAlertDialog({
    required BuildContext context,
    required String msg,
  }) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => showDialog(
        context: context,
        builder: (ctx) {
          return Text(msg);
        },
      ),
    );
  }
}
