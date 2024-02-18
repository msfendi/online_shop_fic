// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:online_shop_fic/data/models/responses/product_response_model.dart';

class ProductQuantityModel {
  Product product;
  int quantity;

  ProductQuantityModel(
    this.product,
    this.quantity,
  );

  ProductQuantityModel copyWith({
    Product? product,
    int? quantity,
  }) {
    return ProductQuantityModel(
      product ?? this.product,
      quantity ?? this.quantity,
    );
  }

  @override
  bool operator ==(covariant ProductQuantityModel other) {
    if (identical(this, other)) return true;

    return other.product == product && other.quantity == quantity;
  }

  @override
  int get hashCode => product.hashCode ^ quantity.hashCode;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': product.toMap(),
      'quantity': quantity,
    };
  }

  factory ProductQuantityModel.fromMap(Map<String, dynamic> map) {
    return ProductQuantityModel(
      Product.fromMap(map['product'] as Map<String, dynamic>),
      map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductQuantityModel.fromJson(String source) =>
      ProductQuantityModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ProductQuantityModel(product: $product, quantity: $quantity)';
}
