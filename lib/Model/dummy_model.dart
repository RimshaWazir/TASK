import 'dart:convert';

class DummyModel {
  final String? id;
  final String? title;
  final String? icon;
  final List<SubCategory>? subCategories;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  DummyModel({
    this.id,
    this.title,
    this.icon,
    this.subCategories,
    this.createdAt,
    this.updatedAt,
  });

  factory DummyModel.fromRawJson(String str) =>
      DummyModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DummyModel.fromJson(Map<String, dynamic> json) => DummyModel(
        id: json["_id"],
        title: json["title"],
        icon: json["icon"],
        subCategories: json["subCategories"] == null
            ? []
            : List<SubCategory>.from(
                json["subCategories"]!.map((x) => SubCategory.fromJson(x))),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "icon": icon,
        "subCategories": subCategories == null
            ? []
            : List<dynamic>.from(subCategories!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class SubCategory {
  final String? id;
  final String? title;
  final String? icon;
  final String? category;
  final List<ChildSubCategory>? childSubCategories;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SubCategory({
    this.id,
    this.title,
    this.icon,
    this.category,
    this.childSubCategories,
    this.createdAt,
    this.updatedAt,
  });

  factory SubCategory.fromRawJson(String str) =>
      SubCategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json["_id"],
        title: json["title"],
        icon: json["icon"],
        category: json["category"],
        childSubCategories: json["childSubCategories"] == null
            ? []
            : List<ChildSubCategory>.from(json["childSubCategories"]!
                .map((x) => ChildSubCategory.fromJson(x))),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "icon": icon,
        "category": category,
        "childSubCategories": childSubCategories == null
            ? []
            : List<dynamic>.from(childSubCategories!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

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

enum Availability { AVAILABILITY_TRUE, FALSE, TRUE }

final availabilityValues = EnumValues({
  "True": Availability.AVAILABILITY_TRUE,
  " False": Availability.FALSE,
  " True": Availability.TRUE
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
