import 'package:flutter/material.dart';
import 'package:flutter_phone_auth/providers/auth_provider.dart';
import 'package:flutter_phone_auth/utils/utils.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: value.phoneNumber,
                  decoration: const InputDecoration(
                      hintText: "Enter Your Phone Number Ex: 712345678"),

                  // controller: value.phoneNumber,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (value.phoneNumber.text.isNotEmpty &&
                        value.phoneNumber.text.length == 9) {
                      value.phoneNumberAuth(context);
                    } else {
                      Utils.showSnackbar(context, "Enter Valied Phone Number");
                    }
                  },
                  child: const Text("Send Otp"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
