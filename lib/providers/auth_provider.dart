import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_auth/utils/utils.dart';
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
        phoneNumber: "+94${_phoneNumber.text}",

        //............Phone number verification complete
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Sign the user in (or link) with the auto-generated credential
          await auth.signInWithCredential(credential);
        },

        //...........Phone number verification Fail
        verificationFailed: (FirebaseAuthException e) {
          Utils.showSnackbar(context, "Phone Number Error");
        },

        //............Code sent
        codeSent: (String verificationId, int? resendToken) async {
          Logger().w("Code sent Success");

          Utils.showOTPDialog(
            context,
            _otpNumber,
            () async {
              String smsCode = _otpNumber.text;
              // // Create a PhoneAuthCredential with the code
              PhoneAuthCredential credential = PhoneAuthProvider.credential(
                verificationId: verificationId,
                smsCode: smsCode,
              );

              // Sign the user in (or link) with the credential
              await auth.signInWithCredential(credential).catchError(
                (e) {
                  Utils.showSnackbar(context, e.toString());
                },
              );
            },
          );
        },

        //..........Resend otp code
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      Logger().e(e);
    }
  }
}
