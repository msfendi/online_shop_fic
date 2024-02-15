import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:online_shop_fic/data/datasource/product_remote_datasource.dart';

import '../../../../data/models/responses/product_response_model.dart';

part 'top_rated_event.dart';
part 'top_rated_state.dart';
part 'top_rated_bloc.freezed.dart';

class TopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {
  final ProductRemoteDatasource _productRemoteDatasource;
  TopRatedBloc(this._productRemoteDatasource) : super(_Initial()) {
    on<_GetTopRated>((event, emit) async {
      final response = await _productRemoteDatasource.getProductByCategoryId(2);

      response.fold(
        (l) => emit(TopRatedState.error('Data gagal ditampilkan')),
        (r) => emit(TopRatedState.loaded(r.data!.data!)),
      );
    });
  }
}
