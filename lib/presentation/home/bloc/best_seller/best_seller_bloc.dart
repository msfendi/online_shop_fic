import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/datasource/product_remote_datasource.dart';
import '../../../../data/models/responses/product_response_model.dart';

part 'best_seller_event.dart';
part 'best_seller_state.dart';
part 'best_seller_bloc.freezed.dart';

class BestSellerBloc extends Bloc<BestSellerEvent, BestSellerState> {
  final ProductRemoteDatasource _productRemoteDatasource;
  BestSellerBloc(this._productRemoteDatasource) : super(const _Initial()) {
    on<_GetBestSeller>((event, emit) async {
      final response = await _productRemoteDatasource.getProductByCategoryId(1);
      response.fold(
        (l) => emit(const BestSellerState.error('Server Mengalami Gangguan')),
        (r) => emit(BestSellerState.loaded(r.data!.data!)),
      );
    });
  }
}
