import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:online_shop_fic/data/datasource/address_remote_datasource.dart';

import '../../../../data/models/requests/address_request_model.dart';

part 'edit_address_event.dart';
part 'edit_address_state.dart';
part 'edit_address_bloc.freezed.dart';

class EditAddressBloc extends Bloc<EditAddressEvent, EditAddressState> {
  AddressRemoteDatasource addressRemoteDatasource;
  EditAddressBloc(this.addressRemoteDatasource)
      : super(const _Loaded('', '', '')) {
    on<EditAddressEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<_AddProvinceId>((event, emit) {
      final currentState = state as _Loaded;
      emit(_Loaded(
          event.provinceId, currentState.cityId, currentState.districtId));
    });

    on<_AddCityId>((event, emit) {
      final currentState = state as _Loaded;
      emit(_Loaded(
          currentState.provinceId, event.cityId, currentState.districtId));
    });

    on<_AddDistrictId>((event, emit) {
      final currentState = state as _Loaded;
      emit(_Loaded(
          currentState.provinceId, currentState.cityId, event.districtId));
    });
  }
}
