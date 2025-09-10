import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String? _email;
  String? _password;

  String? get email => _email;
  String? get password => _password;

  bool get isLoggedIn => _password != null;

  void login({required String email, required String password}) {
    _email = email;
    _password = password;
    notifyListeners();
  }

  void logout() {
    _email = null;
    _password = null;
    notifyListeners();
  }
}
