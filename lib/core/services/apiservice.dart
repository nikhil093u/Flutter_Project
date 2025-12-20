// import 'package:flutter_application/features/orders/order_model.dart';
import 'dart:typed_data';

import 'package:flutter_application/features/customers/customerprovider.dart';
import 'package:flutter_application/features/orders/order_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'https://d28c5r6pnnqv4m.cloudfront.net';
  static final _storage = FlutterSecureStorage();

  static Future<http.Response> get(
  String path, {
  Map<String, String>? queryParams,
}) async {
  final token = await _storage.read(key: 'auth_token');

  final response = await http.get(
    Uri.parse('$baseUrl$path').replace(queryParameters: queryParams),
    headers: {
      if (token != null) 'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 401) {
    await _storage.deleteAll();
  }

  return response;
}


  static Future<http.Response> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/fastapi/api/login');

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
static Future<Map<String, dynamic>> generatePresignedUrl({
  required String filename,
  required String contentType,
}) async {
  final token = await _storage.read(key: 'auth_token');
  final response = await http.post(
    Uri.parse('$baseUrl/fastapi/odoo/order-management/generate-presigned-url'),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'filename': filename,
      'content_type': contentType,
    }),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to generate presigned URL');
  }

  return jsonDecode(response.body);
}
static Future<void> uploadToS3({
  required String uploadUrl,
  required Uint8List bytes,
}) async {
  final response = await http.put(
    Uri.parse(uploadUrl),
    body: bytes,
  );

  if (response.statusCode != 200) {
    throw Exception('S3 upload failed');
  }
}


}
