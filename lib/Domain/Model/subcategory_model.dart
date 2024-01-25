import 'dart:convert';

import 'package:dummy/Domain/Model/child_subcategory_model.dart';

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
