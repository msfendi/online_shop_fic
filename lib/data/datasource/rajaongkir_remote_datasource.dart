import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:online_shop_fic/core/constants/variable.dart';
import 'package:online_shop_fic/data/models/responses/city_response_model.dart';
import 'package:online_shop_fic/data/models/responses/cost_response_model.dart';
import 'package:online_shop_fic/data/models/responses/province_response_model.dart';
import 'package:online_shop_fic/data/models/responses/subdistrict_response_model.dart';

class RajaongkirRemoteDatasource {
  // Fungsi getProvinces digunakan untuk mengambil data provinsi dari server
  Future<Either<String, ProvinceResponse>> getProvinces() async {
    final response = await http
        .get(Uri.parse('${Variables.rajaongkirUrl}/api/province'), headers: {
      'Accept': 'application/json',
      'key': Variables.rajaongkirApiKey,
    });

    // jika status code response adalah 200, maka response body akan diubah menjadi object ProvinceResponse
    if (response.statusCode == 200) {
      return Right(ProvinceResponse.fromJson(response.body));
    } else {
      return const Left('Internal Server Error');
    }
  }

  // Fungsi getCities digunakan untuk mengambil data kota dari server
  Future<Either<String, CityResponse>> getCities(String provinceId) async {
    final response = await http.get(
        Uri.parse('${Variables.rajaongkirUrl}/api/city?province=$provinceId'),
        headers: {
          'key': Variables.rajaongkirApiKey,
        });

    // jika status code response adalah 200, maka response body akan diubah menjadi object CityResponse
    if (response.statusCode == 200) {
      return Right(CityResponse.fromJson(response.body));
    } else {
      return const Left('Internal Server Error');
    }
  }

  // Fungsi getSubdistricts digunakan untuk mengambil data kecamatan dari server
  Future<Either<String, SubdistrictResponse>> getSubdistricts(
      String cityId) async {
    final response = await http.get(
        Uri.parse('${Variables.rajaongkirUrl}/api/subdistrict?city=$cityId'),
        headers: {
          'key': Variables.rajaongkirApiKey,
        });

    // jika status code response adalah 200, maka response body akan diubah menjadi object SubdistrictResponse
    if (response.statusCode == 200) {
      return Right(SubdistrictResponse.fromJson(response.body));
    } else {
      return const Left('Internal Server Error');
    }
  }

  // Fungsi getCost digunakan untuk mengambil data ongkos kirim dari server
  Future<Either<String, CostResponse>> getCost(
      String origin, String destination, int weight, String courier) async {
    final response = await http.post(
      Uri.parse('${Variables.rajaongkirUrl}/api/cost'),
      headers: {
        'key': Variables.rajaongkirApiKey,
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'origin': origin,
        'originType': 'subdistrict',
        'destination': destination,
        'destinationType': 'subdistrict',
        'weight': weight.toString(),
        'courier': courier,
      },
    );

    // jika status code response adalah 200, maka response body akan diubah menjadi object CostResponse
    if (response.statusCode == 200) {
      return Right(CostResponse.fromJson(response.body));
    } else {
      return const Left('Internal Server Error');
    }
  }
}
