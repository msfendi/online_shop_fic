// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AddressRequest {
  final String? name;
  final String? fullAddress;
  final String? phone;
  final String? provId;
  final String? cityId;
  final String? districtId;
  final String? postalCode;
  final bool? isDefault;

  AddressRequest({
    this.name,
    this.fullAddress,
    this.phone,
    this.provId,
    this.cityId,
    this.districtId,
    this.postalCode,
    this.isDefault,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'full_address': fullAddress,
      'phone': phone,
      'prov_id': provId,
      'city_id': cityId,
      'district_id': districtId,
      'postal_code': postalCode,
      'is_default': isDefault,
    };
  }

  factory AddressRequest.fromMap(Map<String, dynamic> map) {
    return AddressRequest(
      name: map['name'] as String,
      fullAddress: map['fullAddress'] as String,
      phone: map['phone'] as String,
      provId: map['provId'] as String,
      cityId: map['cityId'] as String,
      districtId: map['districtId'] as String,
      postalCode: map['postalCode'] as String,
      isDefault: map['isDefault'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressRequest.fromJson(String source) =>
      AddressRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddressRequest(name: $name, full_address: $fullAddress, phone: $phone, prov_id: $provId, city_id: $cityId, district_id: $districtId, postal_code: $postalCode, is_default: $isDefault)';
  }
}
