// import 'package:flutter_application/features/orders/order_model.dart';
import 'package:flutter_application/features/customers/customerprovider.dart';
import 'package:flutter_application/features/orders/order_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static final _baseUrl = 'https://d28c5r6pnnqv4m.cloudfront.net';
  static final _storage = FlutterSecureStorage();

  static Future<http.Response> get(String path, {
  Map<String, String>? queryParams,
}) async {
    final token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJzYWxlc0BnbWFpbC5jb20iLCJ1aWQiOjMwLCJleHAiOjE3NjU5NTQzMDksInR5cGUiOiJhY2Nlc3MifQ.7dYSlLUqykUW7Bi016tKKMbvaZSKMhpQahbtru_z-U0';

    final response = await http.get(
      Uri.parse('$_baseUrl$path').replace(
        queryParameters: queryParams,
      ),
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
    final url = Uri.parse('$_baseUrl/api/login');

    final body = jsonEncode({
      "email": email,
      "password":password,
    });

    final headers = {"Content-Type": "application/json"};

    return await http.post(url, headers: headers, body: body);
  }

  static Future<List<Order>> fetchOrders() async {
  final response = await get(
    '/fastapi/odoo/order-management/orders/sales/orders/sales%40gmail.com?page=1&limit=10',
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> decoded = jsonDecode(response.body);

    final List ordersJson = decoded['orders'];

    return ordersJson
        .map((e) => Order.fromJson(e))
        .toList();
  } else {
    throw Exception('Failed to load orders');
  }
}


  static Future<List<Customer>> fetchCustomers() async {
  final response = await get(
    '/fastapi/odoo/contacts/',
    queryParams: {'cacheable': 'true'},
  );

  if (response.statusCode == 200) {
    final List decoded = jsonDecode(response.body);
    return decoded.map((e) => Customer.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load customers');
  }
}

}
