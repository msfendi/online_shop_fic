import 'dart:convert';

class CategoryResponse {
  final String? status;
  final String? message;
  final List<Category>? data;

  CategoryResponse({
    this.status,
    this.message,
    this.data,
  });

  factory CategoryResponse.fromJson(String str) =>
      CategoryResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryResponse.fromMap(Map<String, dynamic> json) =>
      CategoryResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Category>.from(
                json["data"]!.map((x) => Category.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Category {
  final int? id;
  final String? name;
  final String? slug;
  final String? description;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Category({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        description: json["description"],
        image: json["image"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "slug": slug,
        "description": description,
        "image": image,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
