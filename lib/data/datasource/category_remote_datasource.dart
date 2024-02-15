import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:online_shop_fic/core/constants/variable.dart';
import 'package:online_shop_fic/data/models/responses/category_response_model.dart';

class CategoryRemoteDataSource {
  Future<Either<String, CategoryResponse>> getCategories() async {
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/categories'),
    );

    if (response.statusCode == 200) {
      return Right(CategoryResponse.fromJson(response.body));
    } else {
      return Left('Failed to load categories');
    }
  }
}
