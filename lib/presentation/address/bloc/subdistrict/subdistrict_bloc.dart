import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:online_shop_fic/data/datasource/rajaongkir_remote_datasource.dart';

import '../../../../data/models/responses/subdistrict_response_model.dart';

part 'subdistrict_event.dart';
part 'subdistrict_state.dart';
part 'subdistrict_bloc.freezed.dart';

class SubdistrictBloc extends Bloc<SubdistrictEvent, SubdistrictState> {
  final RajaongkirRemoteDatasource rajaongkirRemoteDatasource;
  SubdistrictBloc(this.rajaongkirRemoteDatasource) : super(const _Initial()) {
    on<_GetSubdistrict>((event, emit) async {
      // TODO: implement event handler
      emit(const _Loading());
      final result =
          await rajaongkirRemoteDatasource.getSubdistricts(event.cityId);

      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.rajaongkir!.results ?? [])),
      );
    });
  }
}
