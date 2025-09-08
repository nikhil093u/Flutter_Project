class Order {
  final String id;
  final String name;
  final String date;
  final String status;

  Order({
    required this.id,
    required this.name,
    required this.date,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['name'] ?? '', 
      name: json['partner_id'] is List ? json['partner_id'][1] : '',
      date: json['date_order'] ?? '',
      status: json['state'] ?? '',
    );
  }
}
