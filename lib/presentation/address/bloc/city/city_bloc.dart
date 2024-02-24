import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:online_shop_fic/data/datasource/rajaongkir_remote_datasource.dart';

import '../../../../data/models/responses/city_response_model.dart';

part 'city_event.dart';
part 'city_state.dart';
part 'city_bloc.freezed.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final RajaongkirRemoteDatasource rajaongkirRemoteDatasource;
  CityBloc(this.rajaongkirRemoteDatasource) : super(const _Initial()) {
    on<_GetCity>((event, emit) async {
      // TODO: implement event handler
      emit(const _Loading());
      final result =
          await rajaongkirRemoteDatasource.getCities(event.provinceId);

      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.rajaongkir!.results ?? [])),
      );
    });
  }
}
