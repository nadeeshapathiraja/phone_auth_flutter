import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_auth/utils/utils.dart';
import 'package:flutter_phone_auth/views/home_screen.dart';
import 'package:flutter_phone_auth/views/login_screen.dart';
import 'package:logger/logger.dart';

class AuthProvider extends ChangeNotifier {
  final TextEditingController _phoneNumber = TextEditingController();
  TextEditingController get phoneNumber => _phoneNumber;

  final TextEditingController _otpNumber = TextEditingController();
  TextEditingController get otpNumber => _otpNumber;

  FirebaseAuth auth = FirebaseAuth.instance;

  //.........Store user data
  final Map<String, dynamic> _userData = {};

  Map<String, dynamic>? get getUserData => _userData;

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
          Utils.showSnackbar(context, e.code);
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

              Logger().w("Success");

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

  //...........initialize user
  Future<void> initializeUser(BuildContext context) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Logger().e('User is currently signed out!');
        Utils.navEgateTo(context, const LoginScreen());
      } else {
        Logger().i('User is signed in!');
        Utils.navEgateTo(context, const HomeScreen());
      }
    });
  }

  Future<void> logOutUser() async {
    await FirebaseAuth.instance.signOut();
  }
}
