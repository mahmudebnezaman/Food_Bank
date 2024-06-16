import 'dart:convert';

class OrderItem {
  final String dineTime;
  final String foodName;
  final String foodImage;
  final String foodDetails;
  int quantity;
  double price;

  OrderItem({
    required this.dineTime,
    required this.foodName,
    required this.foodImage,
    required this.foodDetails,
    required this.quantity,
    required this.price,
  });

  static OrderItem fromJson(String jsonString) {
    final Map<String, dynamic> map = jsonDecode(jsonString);
    return OrderItem(
      dineTime: map['dineTime'] as String,
      foodName: map['foodName'] as String,
      foodImage: map['foodImage'] as String,
      foodDetails: map['foodDetails'] as String,
      quantity: map['quantity'] as int,
      price: map['price'] as double,
    );
  }

  Map<String, dynamic> toJson() => {
        'dineTime': dineTime,
        'foodName': foodName,
        'foodImage': foodImage,
        'foodDetails': foodDetails,
        'quantity': quantity,
        'price': price,
      };

  static OrderItem fromJsonString(String jsonString) =>
      OrderItem.fromJson(json.decode(jsonString));

  String toJsonString() => json.encode(toJson());
}
