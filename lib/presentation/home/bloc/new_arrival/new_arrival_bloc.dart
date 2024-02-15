import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:online_shop_fic/data/datasource/product_remote_datasource.dart';
import 'package:online_shop_fic/data/models/responses/product_response_model.dart';

part 'new_arrival_event.dart';
part 'new_arrival_state.dart';
part 'new_arrival_bloc.freezed.dart';

class NewArrivalBloc extends Bloc<NewArrivalEvent, NewArrivalState> {
  final ProductRemoteDatasource _productRemoteDatasource;
  NewArrivalBloc(this._productRemoteDatasource) : super(const _Initial()) {
    on<_GetNewArrival>((event, emit) async {
      final response = await _productRemoteDatasource.getProductByCategoryId(4);

      response.fold(
          (l) => emit(const NewArrivalState.error('Gagal Menangkap Data')),
          (r) => emit(NewArrivalState.loaded(r.data!.data!)));
    });
  }
}
