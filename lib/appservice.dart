import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static final _baseUrl = 'https://d28c5r6pnnqv4m.cloudfront.net/fastapi/api';
  static final _storage = FlutterSecureStorage();

  static Future<http.Response> get(String path) async {
    final token = await _storage.read(key: 'auth_token');

    final response = await http.get(
      Uri.parse('$_baseUrl$path'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 401) {
      await _storage.delete(key: 'auth_token');
    }
    return response;
  }

  static Future<http.Response> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    return response;
  }
}
