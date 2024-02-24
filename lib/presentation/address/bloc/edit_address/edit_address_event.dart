part of 'edit_address_bloc.dart';

@freezed
class EditAddressEvent with _$EditAddressEvent {
  const factory EditAddressEvent.started() = _Started;
  const factory EditAddressEvent.editAddress({
    required AddressRequest addressRequest,
  }) = _EditAddress;
}
