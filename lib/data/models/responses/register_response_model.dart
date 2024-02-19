import 'dart:convert';

class RegisterResponse {
  final String? accessToken;
  final Data? data;

  RegisterResponse({
    this.accessToken,
    this.data,
  });

  factory RegisterResponse.fromJson(String str) =>
      RegisterResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegisterResponse.fromMap(Map<String, dynamic> json) =>
      RegisterResponse(
        accessToken: json["access_token"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "access_token": accessToken,
        "data": data?.toMap(),
      };
}

class Data {
  final String? name;
  final String? email;
  final String? phone;
  final String? roles;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;

  Data({
    this.name,
    this.email,
    this.phone,
    this.roles,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        roles: json["roles"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "phone": phone,
        "roles": roles,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
