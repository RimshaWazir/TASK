import 'dart:convert';

import 'package:dummy/Domain/Model/product_model.dart';

class ChildSubCategory {
  final String? id;
  final String? title;
  final String? icon;
  final String? category;
  final List<ChildSubCategory>? deepChildSubCategory;
  final String? subCategory;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? data;
  final String? s;
  final List<Product>? products;
  final String? childSubCategory;

  ChildSubCategory({
    this.id,
    this.title,
    this.icon,
    this.category,
    this.deepChildSubCategory,
    this.subCategory,
    this.createdAt,
    this.updatedAt,
    this.data,
    this.s,
    this.products,
    this.childSubCategory,
  });

  factory ChildSubCategory.fromRawJson(String str) =>
      ChildSubCategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChildSubCategory.fromJson(Map<String, dynamic> json) =>
      ChildSubCategory(
        id: json["_id"],
        title: json["title"],
        icon: json["icon"],
        category: json["category"],
        deepChildSubCategory: json["deepChildSubCategory"] == null
            ? []
            : List<ChildSubCategory>.from(json["deepChildSubCategory"]!
                .map((x) => ChildSubCategory.fromJson(x))),
        subCategory: json["subCategory"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        data: json["data"],
        s: json["s"],
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
        childSubCategory: json["childSubCategory"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "icon": icon,
        "category": category,
        "deepChildSubCategory": deepChildSubCategory == null
            ? []
            : List<dynamic>.from(deepChildSubCategory!.map((x) => x.toJson())),
        "subCategory": subCategory,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "data": data,
        "s": s,
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "childSubCategory": childSubCategory,
      };
}
