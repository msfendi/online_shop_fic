import 'dart:convert';

class HistoryOrderResponse {
  final List<HistoryOrder>? data;

  HistoryOrderResponse({
    this.data,
  });

  factory HistoryOrderResponse.fromJson(String str) =>
      HistoryOrderResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HistoryOrderResponse.fromMap(Map<String, dynamic> json) =>
      HistoryOrderResponse(
        data: json["data"] == null
            ? []
            : List<HistoryOrder>.from(
                json["data"]!.map((x) => HistoryOrder.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class HistoryOrder {
  final int? id;
  final int? userId;
  final int? addressId;
  final int? subtotal;
  final int? shippingCost;
  final int? totalPrice;
  final String? status;
  final String? paymentMethod;
  final String? paymentVaName;
  final String? paymentVaNumber;
  final dynamic paymentEwalletName;
  final dynamic paymentEwalletNumber;
  final String? shippingService;
  final dynamic shippingResi;
  final String? transactionNumber;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  HistoryOrder({
    this.id,
    this.userId,
    this.addressId,
    this.subtotal,
    this.shippingCost,
    this.totalPrice,
    this.status,
    this.paymentMethod,
    this.paymentVaName,
    this.paymentVaNumber,
    this.paymentEwalletName,
    this.paymentEwalletNumber,
    this.shippingService,
    this.shippingResi,
    this.transactionNumber,
    this.createdAt,
    this.updatedAt,
  });

  factory HistoryOrder.fromJson(String str) =>
      HistoryOrder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HistoryOrder.fromMap(Map<String, dynamic> json) => HistoryOrder(
        id: json["id"],
        userId: json["user_id"],
        addressId: json["address_id"],
        subtotal: json["subtotal"],
        shippingCost: json["shipping_cost"],
        totalPrice: json["total_price"],
        status: json["status"],
        paymentMethod: json["payment_method"],
        paymentVaName: json["payment_va_name"],
        paymentVaNumber: json["payment_va_number"],
        paymentEwalletName: json["payment_ewallet_name"],
        paymentEwalletNumber: json["payment_ewallet_number"],
        shippingService: json["shipping_service"],
        shippingResi: json["shipping_resi"],
        transactionNumber: json["transaction_number"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "address_id": addressId,
        "subtotal": subtotal,
        "shipping_cost": shippingCost,
        "total_price": totalPrice,
        "status": status,
        "payment_method": paymentMethod,
        "payment_va_name": paymentVaName,
        "payment_va_number": paymentVaNumber,
        "payment_ewallet_name": paymentEwalletName,
        "payment_ewallet_number": paymentEwalletNumber,
        "shipping_service": shippingService,
        "shipping_resi": shippingResi,
        "transaction_number": transactionNumber,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
