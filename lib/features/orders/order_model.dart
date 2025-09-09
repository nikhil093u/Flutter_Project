// models/order.dart

class Order {
  final String id;
  final String customerName;
  final DateTime date;
  final String status;

  final String waterType;
  final String bottleMaterial;
  final String bottleShape;
  final String sizeQuantity;
  final String colorCombination;
  final String preDesignOption;
  final String textOnBottle;
  final String socialNetwork1;
  final String socialNetwork2;

  Order({
    required this.id,
    required this.customerName,
    required this.date,
    required this.status,
    required this.waterType,
    required this.bottleMaterial,
    required this.bottleShape,
    required this.sizeQuantity,
    required this.colorCombination,
    required this.preDesignOption,
    required this.textOnBottle,
    required this.socialNetwork1,
    required this.socialNetwork2,
  });
}
