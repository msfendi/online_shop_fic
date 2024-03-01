import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:online_shop_fic/data/models/responses/address_response_model.dart';

import '../../../../data/datasource/address_remote_datasource.dart';

part 'address_event.dart';
part 'address_state.dart';
part 'address_bloc.freezed.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  // AddressRemoteDatasource adalah class yang berfungsi untuk mengambil data alamat dari server
  final AddressRemoteDatasource addressRemoteDatasource;

  AddressBloc(this.addressRemoteDatasource) : super(const _Initial()) {
    // Ketika event getAddress dipanggil, maka akan mengirim request ke server untuk mengambil data alamat
    on<_GetAddress>((event, emit) async {
      emit(const _Loading());
      // mengambil data alamat dari server
      final result = await addressRemoteDatasource.getAddress();
      // jika response dari server adalah success, maka akan mengubah response body menjadi object AddressResponse
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data!)),
      );
    });

    // ketika event show
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
