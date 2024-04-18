import 'dart:convert';

class OrderRequest {
  final int? addressId;
  final String? paymentMethod;
  final String? paymentVaName;
  final String? shippingService;
  final int? shippingCost;
  final int? subtotal;
  final int? totalPrice;
  final List<Item>? items;

  OrderRequest({
    this.addressId,
    this.paymentMethod,
    this.paymentVaName,
    this.shippingService,
    this.shippingCost,
    this.subtotal,
    this.totalPrice,
    this.items,
  });

  factory OrderRequest.fromJson(String str) =>
      OrderRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderRequest.fromMap(Map<String, dynamic> json) => OrderRequest(
        addressId: json["address_id"],
        paymentMethod: json["payment_method"],
        paymentVaName: json["payment_va_name"],
        shippingService: json["shipping_service"],
        shippingCost: json["shipping_cost"],
        subtotal: json["subtotal"],
        totalPrice: json["total_price"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "address_id": addressId,
        "payment_method": paymentMethod,
        "payment_va_name": paymentVaName,
        "shipping_service": shippingService,
        "shipping_cost": shippingCost,
        "subtotal": subtotal,
        "total_price": totalPrice,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toMap())),
      };
}

class Item {
  final int? productId;
  final int? quantity;

  Item({
    this.productId,
    this.quantity,
  });

  factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        productId: json["product_id"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toMap() => {
        "product_id": productId,
        "quantity": quantity,
      };
}
