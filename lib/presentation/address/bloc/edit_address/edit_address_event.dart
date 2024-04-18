part of 'edit_address_bloc.dart';

@freezed
class EditAddressEvent with _$EditAddressEvent {
  const factory EditAddressEvent.started() = _Started;
  const factory EditAddressEvent.editAddress({
    required AddressRequest addressRequest,
  }) = _EditAddress;

  const factory EditAddressEvent.addProvinceId(String provinceId) =
      _AddProvinceId;
  const factory EditAddressEvent.addCityId(String cityId) = _AddCityId;
  const factory EditAddressEvent.addDistrictId(String districtId) =
      _AddDistrictId;
}
