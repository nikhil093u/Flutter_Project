// import 'package:flutter_application/features/orders/order_model.dart';
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

  static Future<http.Response> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$_baseUrl/login');

    final body = jsonEncode({
      "email": email,
      "password":password,
    });

    final headers = {"Content-Type": "application/json"};

    return await http.post(url, headers: headers, body: body);
  }

  // static Future<List<Order>> fetchOrders() async {
  //   final response = await get('/odoo/orders');

  //   print('Fetch Orders Status: ${response.statusCode}');
  //   print('Body: ${response.body}');

  //   if (response.statusCode == 200) {
  //     final List<dynamic> data = json.decode(response.body);
  //     return data.map((json) => Order.fromJson(json)).toList();
  //   } else {
  //     throw Exception('Failed to load orders');
  //   }
  // }
}
