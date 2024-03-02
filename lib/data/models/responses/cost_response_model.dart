import 'dart:convert';

class CostResponse {
  final Rajaongkir? rajaongkir;

  CostResponse({
    this.rajaongkir,
  });

  factory CostResponse.fromJson(String str) =>
      CostResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CostResponse.fromMap(Map<String, dynamic> json) => CostResponse(
        rajaongkir: json["rajaongkir"] == null
            ? null
            : Rajaongkir.fromMap(json["rajaongkir"]),
      );

  Map<String, dynamic> toMap() => {
        "rajaongkir": rajaongkir?.toMap(),
      };
}

class Rajaongkir {
  final Query? query;
  final Status? status;
  final OriginDetails? originDetails;
  final DestinationDetails? destinationDetails;
  final List<Result>? results;

  Rajaongkir({
    this.query,
    this.status,
    this.originDetails,
    this.destinationDetails,
    this.results,
  });

  factory Rajaongkir.fromJson(String str) =>
      Rajaongkir.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Rajaongkir.fromMap(Map<String, dynamic> json) => Rajaongkir(
        query: json["query"] == null ? null : Query.fromMap(json["query"]),
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
        originDetails: json["origin_details"] == null
            ? null
            : OriginDetails.fromMap(json["origin_details"]),
        destinationDetails: json["destination_details"] == null
            ? null
            : DestinationDetails.fromMap(json["destination_details"]),
        results: json["results"] == null
            ? []
            : List<Result>.from(json["results"]!.map((x) => Result.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "query": query?.toMap(),
        "status": status?.toMap(),
        "origin_details": originDetails?.toMap(),
        "destination_details": destinationDetails?.toMap(),
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toMap())),
      };
}

class DestinationDetails {
  final String? subdistrictId;
  final String? provinceId;
  final String? province;
  final String? cityId;
  final String? city;
  final String? type;
  final String? subdistrictName;

  DestinationDetails({
    this.subdistrictId,
    this.provinceId,
    this.province,
    this.cityId,
    this.city,
    this.type,
    this.subdistrictName,
  });

  factory DestinationDetails.fromJson(String str) =>
      DestinationDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DestinationDetails.fromMap(Map<String, dynamic> json) =>
      DestinationDetails(
        subdistrictId: json["subdistrict_id"],
        provinceId: json["province_id"],
        province: json["province"],
        cityId: json["city_id"],
        city: json["city"],
        type: json["type"],
        subdistrictName: json["subdistrict_name"],
      );

  Map<String, dynamic> toMap() => {
        "subdistrict_id": subdistrictId,
        "province_id": provinceId,
        "province": province,
        "city_id": cityId,
        "city": city,
        "type": type,
        "subdistrict_name": subdistrictName,
      };
}

class OriginDetails {
  final String? cityId;
  final String? provinceId;
  final String? province;
  final String? type;
  final String? cityName;
  final String? postalCode;

  OriginDetails({
    this.cityId,
    this.provinceId,
    this.province,
    this.type,
    this.cityName,
    this.postalCode,
  });

  factory OriginDetails.fromJson(String str) =>
      OriginDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OriginDetails.fromMap(Map<String, dynamic> json) => OriginDetails(
        cityId: json["city_id"],
        provinceId: json["province_id"],
        province: json["province"],
        type: json["type"],
        cityName: json["city_name"],
        postalCode: json["postal_code"],
      );

  Map<String, dynamic> toMap() => {
        "city_id": cityId,
        "province_id": provinceId,
        "province": province,
        "type": type,
        "city_name": cityName,
        "postal_code": postalCode,
      };
}

class Query {
  final String? origin;
  final String? destination;
  final int? weight;
  final String? courier;
  final String? originType;
  final String? destinationType;

  Query({
    this.origin,
    this.destination,
    this.weight,
    this.courier,
    this.originType,
    this.destinationType,
  });

  factory Query.fromJson(String str) => Query.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Query.fromMap(Map<String, dynamic> json) => Query(
        origin: json["origin"],
        destination: json["destination"],
        weight: json["weight"],
        courier: json["courier"],
        originType: json["originType"],
        destinationType: json["destinationType"],
      );

  Map<String, dynamic> toMap() => {
        "origin": origin,
        "destination": destination,
        "weight": weight,
        "courier": courier,
        "originType": originType,
        "destinationType": destinationType,
      };
}

class Result {
  final String? code;
  final String? name;
  final List<ResultCost>? costs;

  Result({
    this.code,
    this.name,
    this.costs,
  });

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        code: json["code"],
        name: json["name"],
        costs: json["costs"] == null
            ? []
            : List<ResultCost>.from(
                json["costs"]!.map((x) => ResultCost.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "name": name,
        "costs": costs == null
            ? []
            : List<dynamic>.from(costs!.map((x) => x.toMap())),
      };
}

class ResultCost {
  final String? service;
  final String? description;
  final List<CostCost>? cost;

  ResultCost({
    this.service,
    this.description,
    this.cost,
  });

  factory ResultCost.fromJson(String str) =>
      ResultCost.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResultCost.fromMap(Map<String, dynamic> json) => ResultCost(
        service: json["service"],
        description: json["description"],
        cost: json["cost"] == null
            ? []
            : List<CostCost>.from(
                json["cost"]!.map((x) => CostCost.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "service": service,
        "description": description,
        "cost":
            cost == null ? [] : List<dynamic>.from(cost!.map((x) => x.toMap())),
      };
}

class CostCost {
  final int? value;
  final String? etd;
  final String? note;

  CostCost({
    this.value,
    this.etd,
    this.note,
  });

  factory CostCost.fromJson(String str) => CostCost.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CostCost.fromMap(Map<String, dynamic> json) => CostCost(
        value: json["value"],
        etd: json["etd"],
        note: json["note"],
      );

  Map<String, dynamic> toMap() => {
        "value": value,
        "etd": etd,
        "note": note,
      };
}

class Status {
  final int? code;
  final String? description;

  Status({
    this.code,
    this.description,
  });

  factory Status.fromJson(String str) => Status.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Status.fromMap(Map<String, dynamic> json) => Status(
        code: json["code"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "description": description,
      };
}
