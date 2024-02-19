import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:online_shop_fic/core/constants/variable.dart';
import 'package:online_shop_fic/data/datasource/auth_local_datasource.dart';
import 'package:online_shop_fic/data/models/responses/auth_response_model.dart';

// AuthRemoteDatasource adalah class yang berfungsi untuk mengambil data autentikasi dari server

class AuthRemoteDatasource {
  // Function login digunakan untuk mengambil data autentikasi dari server
  Future<Either<String, AuthResponse>> login(
      String email, String password) async {
    final response =
        await http.post(Uri.parse('${Variables.baseUrl}/api/login'), body: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      return Right(AuthResponse.fromJson(response.body));
    } else {
      return const Left('Internal Server Error');
    }
  }

  // Function register digunakan untuk mengambil data autentikasi dari server
  Future<Either<String, AuthResponse>> register(
      String name, String email, String password) async {
    final response =
        await http.post(Uri.parse('${Variables.baseUrl}/api/register'), body: {
      'name': name,
      'email': email,
      'password': password,
      'phone': '081234567890',
      'roles': 'USER',
    });
    print(response.body);
    if (response.statusCode == 200) {
      return Right(AuthResponse.fromJson(response.body));
    } else {
      return const Left('Internal Server Error');
    }
  }

  // Function logout
  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
        Uri.parse(
          '${Variables.baseUrl}/api/logout',
        ),
        headers: {
          'Authorization': 'Bearer ${authData?.accessToken}',
        });

    if (response.statusCode == 200) {
      AuthLocalDatasource().removeAuthData();
      return const Right('Logout Success');
    } else {
      return const Left('Internal Server Error');
    }
  }
}
