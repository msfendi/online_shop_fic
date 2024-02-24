import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:online_shop_fic/core/constants/variable.dart';
import 'package:online_shop_fic/data/datasource/auth_local_datasource.dart';
import 'package:online_shop_fic/data/models/requests/address_request_model.dart';
import 'package:online_shop_fic/data/models/responses/address_response_model.dart';

class AddressRemoteDatasource {
  Future<Either<String, AddressResponse>> getAddress() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response =
        await http.get(Uri.parse('${Variables.baseUrl}/api/address'), headers: {
      'Authorization': 'Bearer ${authData?.accessToken}',
    });

    if (response.statusCode == 200) {
      return Right(AddressResponse.fromJson(response.body));
    } else {
      return const Left('Internal Server Error');
    }
  }

  Future<Either<String, AddressResponse>> getAddressById(int id) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/address/$id'),
      headers: {
        'Authorization': 'Bearer ${authData?.accessToken}',
      },
    );

    if (response.statusCode == 201) {
      return Right(AddressResponse.fromJson(response.body));
    } else {
      return const Left('Internal Server Error');
    }
  }

  Future<Either<String, String>> addAddress(AddressRequest data) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/address'),
      headers: {
        'Authorization': 'Bearer ${authData?.accessToken}',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: data.toJson(),
    );

    if (response.statusCode == 201) {
      return const Right('Success');
    } else {
      return const Left('Internal Server Error');
    }
  }
}
