import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:online_shop_fic/data/models/responses/address_response_model.dart';

import '../../../../data/datasource/address_remote_datasource.dart';

part 'address_event.dart';
part 'address_state.dart';
part 'address_bloc.freezed.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddressRemoteDatasource addressRemoteDatasource;
  AddressBloc(this.addressRemoteDatasource) : super(const _Initial()) {
    on<_GetAddress>((event, emit) async {
      emit(const _Loading());
      final result = await addressRemoteDatasource.getAddress();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data!)),
      );
    });

    on<_ShowAddress>((event, emit) async {
      emit(const _Loading());
      final result = await addressRemoteDatasource.getAddressById(event.id);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded([r.data!.first])),
      );
    });
  }
}
