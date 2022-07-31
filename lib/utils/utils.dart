import 'package:flutter/material.dart';

class Utils {
  static void navEgateTo(BuildContext context, Widget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
  }

  static void showSnackbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
        ),
      ),
    );
  }
}
