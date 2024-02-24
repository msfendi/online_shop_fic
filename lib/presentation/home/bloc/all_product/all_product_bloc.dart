import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:online_shop_fic/data/models/responses/product_response_model.dart';

import '../../../../../data/datasource/product_remote_datasource.dart';

part 'all_product_event.dart';
part 'all_product_state.dart';
part 'all_product_bloc.freezed.dart';

class AllProductBloc extends Bloc<AllProductEvent, AllProductState> {
  final ProductRemoteDatasource _productRemoteDatasource;
  AllProductBloc(this._productRemoteDatasource) : super(const _Initial()) {
    on<_GetProducts>((event, emit) async {
      final response = await _productRemoteDatasource.getAllProduct();

      response.fold(
        (l) => emit(const AllProductState.error('Server Mengalami Gangguan')),
        (r) => emit(AllProductState.loaded(r.data!.data!)),
      );
    });
  }
}
