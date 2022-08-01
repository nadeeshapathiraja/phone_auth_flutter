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

  static void showOTPDialog(
    BuildContext context,
    TextEditingController otpCodeController,
    Function() onPressed,
  ) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Enter OTP"),
        content: TextField(
          keyboardType: TextInputType.number,
          controller: otpCodeController,
        ),
        actions: [
          TextButton(
            onPressed: onPressed,
            child: const Text("Verify"),
          ),
        ],
      ),
    );
  }
}
