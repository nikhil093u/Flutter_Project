import 'package:flutter/material.dart';

class User {
  final String firstName;
  final String lastName;
  final String dob;
  final String email;
  final String phone;
  final String password;

  User({
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.email,
    required this.phone,
    required this.password,
  });
}


class AuthProvider with ChangeNotifier {
  final List<User> _users = [];
  User? _currentUser;

  List<User> get users => _users;
  User? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  bool signUp(User newUser) {
    final exists = _users.any((user) => user.email == newUser.email);
    if (exists) return false;

    _users.add(newUser);
    _currentUser = newUser;
    notifyListeners();
    return true;
  }

  bool signIn({required String email, required String password}) {
    final matchedUser = _users.firstWhere(
      (user) => user.email == email && user.password == password,
      orElse: () => User(
        firstName: '',
        lastName: '',
        dob: '',
        email: '',
        phone: '',
        password: '',
      ),
    );

    if (matchedUser.email.isEmpty) return false;

    _currentUser = matchedUser;
    notifyListeners();
    return true;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
