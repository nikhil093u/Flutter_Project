class Order {
  final String id;
  final String customerName;
  final DateTime date;
  final String status;

  Order({
    required this.id,
    required this.customerName,
    required this.date,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['order_id'].toString(),
      customerName: json['customer'] ?? '',
      date: DateTime.parse(json['date_order']),
      status: json['state'] ?? '',
    );
  }
}
