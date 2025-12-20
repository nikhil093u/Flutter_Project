import 'package:flutter/material.dart';
import 'package:flutter_application/features/auth/usermodel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class AuthProvider with ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  AuthUser? _user;

  AuthUser? get user => _user;
  bool get isLoggedIn => _user != null;

  /// Called after successful login
  Future<void> setUser(AuthUser user) async {
    _user = user;

    await _storage.write(key: 'auth_token', value: user.accessToken);
    await _storage.write(key: 'user_data', value: userToJson(user));

    notifyListeners();
  }

  /// Restore login on app start
  Future<void> loadUserFromStorage() async {
    final token = await _storage.read(key: 'auth_token');
    final userJson = await _storage.read(key: 'user_data');

    if (token != null && userJson != null) {
      _user = authUserFromJson(userJson);
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _user = null;
    await _storage.deleteAll();
    notifyListeners();
  }
}
