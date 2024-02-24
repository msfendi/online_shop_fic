part of 'edit_address_bloc.dart';

@freezed
class EditAddressState with _$EditAddressState {
  const factory EditAddressState.initial() = _Initial;
  const factory EditAddressState.loading() = _Loading;
  const factory EditAddressState.loaded() = _Loaded;
  const factory EditAddressState.error(String message) = _Error;
}
