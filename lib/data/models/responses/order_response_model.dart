import 'dart:convert';

class OrderResponse {
  final String? status;
  final String? message;
  final Data? data;

  OrderResponse({
    this.status,
    this.message,
    this.data,
  });

  factory OrderResponse.fromJson(String str) =>
      OrderResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderResponse.fromMap(Map<String, dynamic> json) => OrderResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data?.toMap(),
      };
}

class Data {
  final int? userId;
  final int? addressId;
  final int? subtotal;
  final int? shippingCost;
  final int? totalPrice;
  final String? status;
  final String? paymentMethod;
  final String? shippingService;
  final dynamic shippingResi;
  final String? transactionNumber;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;
  final String? paymentVaName;
  final String? paymentVaNumber;
  final User? user;
  final List<OrderItem>? orderItems;

  Data({
    this.userId,
    this.addressId,
    this.subtotal,
    this.shippingCost,
    this.totalPrice,
    this.status,
    this.paymentMethod,
    this.shippingService,
    this.shippingResi,
    this.transactionNumber,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.paymentVaName,
    this.paymentVaNumber,
    this.user,
    this.orderItems,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        addressId: json["address_id"],
        subtotal: json["subtotal"],
        shippingCost: json["shipping_cost"],
        totalPrice: json["total_price"],
        status: json["status"],
        paymentMethod: json["payment_method"],
        shippingService: json["shipping_service"],
        shippingResi: json["shipping_resi"],
        transactionNumber: json["transaction_number"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
        paymentVaName: json["payment_va_name"],
        paymentVaNumber: json["payment_va_number"],
        user: json["user"] == null ? null : User.fromMap(json["user"]),
        orderItems: json["order_items"] == null
            ? []
            : List<OrderItem>.from(
                json["order_items"]!.map((x) => OrderItem.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "user_id": userId,
        "address_id": addressId,
        "subtotal": subtotal,
        "shipping_cost": shippingCost,
        "total_price": totalPrice,
        "status": status,
        "payment_method": paymentMethod,
        "shipping_service": shippingService,
        "shipping_resi": shippingResi,
        "transaction_number": transactionNumber,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
        "payment_va_name": paymentVaName,
        "payment_va_number": paymentVaNumber,
        "user": user?.toMap(),
        "order_items": orderItems == null
            ? []
            : List<dynamic>.from(orderItems!.map((x) => x.toMap())),
      };
}

class OrderItem {
  final int? id;
  final int? orderId;
  final int? productId;
  final int? quantity;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Product? product;

  OrderItem({
    this.id,
    this.orderId,
    this.productId,
    this.quantity,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  factory OrderItem.fromJson(String str) => OrderItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderItem.fromMap(Map<String, dynamic> json) => OrderItem(
        id: json["id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        product:
            json["product"] == null ? null : Product.fromMap(json["product"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "order_id": orderId,
        "product_id": productId,
        "quantity": quantity,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "product": product?.toMap(),
      };
}

class Product {
  final int? id;
  final int? categoryId;
  final String? name;
  final String? slug;
  final String? description;
  final String? image;
  final int? price;
  final int? stock;
  final int? isAvailable;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Product({
    this.id,
    this.categoryId,
    this.name,
    this.slug,
    this.description,
    this.image,
    this.price,
    this.stock,
    this.isAvailable,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        categoryId: json["category_id"],
        name: json["name"],
        slug: json["slug"],
        description: json["description"],
        image: json["image"],
        price: json["price"],
        stock: json["stock"],
        isAvailable: json["is_available"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "category_id": categoryId,
        "name": name,
        "slug": slug,
        "description": description,
        "image": image,
        "price": price,
        "stock": stock,
        "is_available": isAvailable,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class User {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? roles;
  final dynamic emailVerifiedAt;
  final dynamic twoFactorSecret;
  final dynamic twoFactorRecoveryCodes;
  final dynamic twoFactorConfirmedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.roles,
    this.emailVerifiedAt,
    this.twoFactorSecret,
    this.twoFactorRecoveryCodes,
    this.twoFactorConfirmedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        roles: json["roles"],
        emailVerifiedAt: json["email_verified_at"],
        twoFactorSecret: json["two_factor_secret"],
        twoFactorRecoveryCodes: json["two_factor_recovery_codes"],
        twoFactorConfirmedAt: json["two_factor_confirmed_at"],
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
        "email": email,
        "phone": phone,
        "roles": roles,
        "email_verified_at": emailVerifiedAt,
        "two_factor_secret": twoFactorSecret,
        "two_factor_recovery_codes": twoFactorRecoveryCodes,
        "two_factor_confirmed_at": twoFactorConfirmedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
