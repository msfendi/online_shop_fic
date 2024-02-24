import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:online_shop_fic/data/datasource/rajaongkir_remote_datasource.dart';

import '../../../../data/models/responses/province_response_model.dart';

part 'province_event.dart';
part 'province_state.dart';
part 'province_bloc.freezed.dart';

class ProvinceBloc extends Bloc<ProvinceEvent, ProvinceState> {
  final RajaongkirRemoteDatasource rajaongkirRemoteDatasource;
  ProvinceBloc(this.rajaongkirRemoteDatasource) : super(const _Initial()) {
    on<_GetProvince>((event, emit) async {
      emit(const _Loading());
      final result = await rajaongkirRemoteDatasource.getProvinces();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.rajaongkir!.results ?? [])),
      );
    });
  }
}
