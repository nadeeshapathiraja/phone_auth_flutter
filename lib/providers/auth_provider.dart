import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
  late TextEditingController _phoneNumber;

  TextEditingController get phoneNumber => _phoneNumber;
}
