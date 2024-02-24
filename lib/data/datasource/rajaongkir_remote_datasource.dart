import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:online_shop_fic/core/constants/variable.dart';
import 'package:online_shop_fic/data/models/responses/city_response_model.dart';
import 'package:online_shop_fic/data/models/responses/province_response_model.dart';
import 'package:online_shop_fic/data/models/responses/subdistrict_response_model.dart';

class RajaongkirRemoteDatasource {
  Future<Either<String, ProvinceResponse>> getProvinces() async {
    final response = await http
        .get(Uri.parse('${Variables.rajaongkirUrl}/api/province'), headers: {
      'Accept': 'application/json',
      'key': Variables.rajaongkirApiKey,
    });

    if (response.statusCode == 200) {
      return Right(ProvinceResponse.fromJson(response.body));
    } else {
      return const Left('Internal Server Error');
    }
  }

  Future<Either<String, CityResponse>> getCities(String provinceId) async {
    final response = await http.get(
        Uri.parse('${Variables.rajaongkirUrl}/api/city?province=$provinceId'),
        headers: {
          'key': Variables.rajaongkirApiKey,
        });

    if (response.statusCode == 200) {
      return Right(CityResponse.fromJson(response.body));
    } else {
      return const Left('Internal Server Error');
    }
  }

  Future<Either<String, SubdistrictResponse>> getSubdistricts(
      String cityId) async {
    final response = await http.get(
        Uri.parse('${Variables.rajaongkirUrl}/api/subdistrict?city=$cityId'),
        headers: {
          'key': Variables.rajaongkirApiKey,
        });

    if (response.statusCode == 200) {
      return Right(SubdistrictResponse.fromJson(response.body));
    } else {
      return const Left('Internal Server Error');
    }
  }
}
