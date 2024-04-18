import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:online_shop_fic/data/datasource/auth_local_datasource.dart';
import 'package:online_shop_fic/data/models/requests/order_request_model.dart';
import 'package:online_shop_fic/data/models/responses/order_response_model.dart';

import '../../core/constants/variable.dart';

class OrderRemoteDatasource {
  // Fungsi createOrder digunakan untuk menyimpan data order dengan mengirimkan class OrderRequest dalam bentuk JSON ke server
  Future<Either<String, OrderResponse>> createOrder(OrderRequest data) async {
    final authData = await AuthLocalDatasource().getAuthData();

    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/order'),
      headers: {
        // 'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.accessToken}',
      },
      body: data.toJson(),
    );

    if (response.statusCode == 201) {
      return Right(OrderResponse.fromJson(response.body));
    } else {
      print(response.statusCode);
      return const Left('Internal Server Error');
    }
  }

  // Fungsi checkStatus by id order
  Future<Either<String, String>> checkStatus(int id) async {
    final authData = await AuthLocalDatasource().getAuthData();

    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/order/status/$id'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData?.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      return Right(response.body);
    } else {
      return const Left('Internal Server Error');
    }
  }
}
