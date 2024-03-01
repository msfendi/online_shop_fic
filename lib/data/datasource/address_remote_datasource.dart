import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:online_shop_fic/core/constants/variable.dart';
import 'package:online_shop_fic/data/datasource/auth_local_datasource.dart';
import 'package:online_shop_fic/data/models/requests/address_request_model.dart';
import 'package:online_shop_fic/data/models/responses/address_response_model.dart';

class AddressRemoteDatasource {
  // Fungsi getAddress digunakan untuk mengambil data alamat dari server
  Future<Either<String, AddressResponse>> getAddress() async {
    // mengambil data autentikasi terlogin dari local storage
    final authData = await AuthLocalDatasource().getAuthData();

    // mengirim request ke server untuk mengambil data alamat
    final response =
        await http.get(Uri.parse('${Variables.baseUrl}/api/address'), headers: {
      'Authorization': 'Bearer ${authData?.accessToken}',
    });

    // jika status code response adalah 200, maka response body akan diubah menjadi object AddressResponse
    if (response.statusCode == 200) {
      return Right(AddressResponse.fromJson(response.body));
    } else {
      return const Left('Internal Server Error');
    }
  }

  // Fungsi getAddressById digunakan untuk mengambil data alamat berdasarkan id dari server
  Future<Either<String, AddressResponse>> getAddressById(int id) async {
    // mengambil data autentikasi terlogin dari local storage
    final authData = await AuthLocalDatasource().getAuthData();

    // mengirim request ke server untuk mengambil data alamat berdasarkan id
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/address/$id'),
      headers: {
        'Authorization': 'Bearer ${authData?.accessToken}',
      },
    );

    // jika status code response adalah 200, maka response body akan diubah menjadi object AddressResponse
    if (response.statusCode == 201) {
      return Right(AddressResponse.fromJson(response.body));
    } else {
      return const Left('Internal Server Error');
    }
  }

  // Fungsi addAddress digunakan untuk menambahkan data alamat ke server
  Future<Either<String, String>> addAddress(AddressRequest data) async {
    // mengambil data autentikasi terlogin dari local storage
    final authData = await AuthLocalDatasource().getAuthData();

    // mengirim request ke server untuk menambahkan data alamat
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/address'),
      headers: {
        'Authorization': 'Bearer ${authData?.accessToken}',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: data.toJson(),
    );

    // jika status code response adalah 201, maka response body akan diubah menjadi object AddressResponse
    if (response.statusCode == 201) {
      return const Right('Success');
    } else {
      return const Left('Internal Server Error');
    }
  }
}
