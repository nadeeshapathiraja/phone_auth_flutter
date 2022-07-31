import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class AuthProvider extends ChangeNotifier {
  final TextEditingController _phoneNumber = TextEditingController();
  TextEditingController get phoneNumber => _phoneNumber;

  final TextEditingController _otpNumber = TextEditingController();
  TextEditingController get otpNumber => _otpNumber;

  FirebaseAuth auth = FirebaseAuth.instance;

  //Phone number auth set
  Future<void> phoneNumberAuth(BuildContext context) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+94$_phoneNumber.toString()",
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Sign the user in (or link) with the auto-generated credential
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                e.toString(),
              ),
            ),
          );
        },
        codeSent: (String verificationId, int? resendToken) {},
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      Logger().e(e);
    }
  }
}
