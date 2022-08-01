import 'package:flutter/material.dart';
import 'package:flutter_phone_auth/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<AuthProvider>(
          builder: (context, value, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Home Screen"),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    value.logOutUser();
                  },
                  child: const Text("Log Out"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
