part of 'address_bloc.dart';

@freezed
class AddressEvent with _$AddressEvent {
  const factory AddressEvent.started() = _Started;
  const factory AddressEvent.getAddress() = _GetAddress;
  const factory AddressEvent.showAddress({
    required int id,
  }) = _ShowAddress;
}
