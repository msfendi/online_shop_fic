import 'package:dartz/dartz.dart';
import 'package:online_shop_fic/data/models/responses/product_response_model.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/variable.dart';

class ProductRemoteDatasource {
  Future<Either<String, ProductResponse>> getAllProduct() async {
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/products'),
    );

    if (response.statusCode == 200) {
      return Right(ProductResponse.fromJson(response.body));
    } else {
      return Left('Failed to load products');
    }
  }

  Future<Either<String, ProductResponse>> getProductByCategoryId(
      int categoryId) async {
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/products?category_id=$categoryId'),
    );

    if (response.statusCode == 200) {
      return Right(ProductResponse.fromJson(response.body));
    } else {
      return Left('Failed to load products');
    }
  }
}
