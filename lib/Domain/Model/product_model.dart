import 'dart:convert';

import 'package:dummy/Data/DataSource/Resources/enums.dart';

class Product {
  final String? productId;
  final String? productName;
  final double? price;
  final Availability? availability;

  Product({
    this.productId,
    this.productName,
    this.price,
    this.availability,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["productId"],
        productName: json["productName"],
        price: json["price"]?.toDouble(),
        availability: availabilityValues.map[json["availability"]]!,
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "productName": productName,
        "price": price,
        "availability": availabilityValues.reverse[availability],
      };
}
