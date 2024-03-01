import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:online_shop_fic/data/datasource/address_remote_datasource.dart';
// import 'package:online_shop_fic/data/models/responses/address_response_model.dart';

import '../../../../data/models/requests/address_request_model.dart';

part 'add_address_event.dart';
part 'add_address_state.dart';
part 'add_address_bloc.freezed.dart';

class AddAddressBloc extends Bloc<AddAddressEvent, AddAddressState> {
  final AddressRemoteDatasource addressRemoteDatasource;
  AddAddressBloc(this.addressRemoteDatasource) : super(const _Initial()) {
    // Ketika event _AddAddress dipanggil, maka akan mengirim request
    on<_AddAddress>((event, emit) async {
      emit(const _Loading());
      final result =
          await addressRemoteDatasource.addAddress(event.addressRequest);
      // jika response dari server adalah success, maka akan mengubah response body menjadi object AddressResponse
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(const _Loaded()),
      );
    });
  }
}
