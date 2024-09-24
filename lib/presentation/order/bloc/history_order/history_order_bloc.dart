import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:online_shop_fic/data/models/responses/history_order_response_model.dart';

import '../../../../data/datasource/order_remote_datasource.dart';

part 'history_order_event.dart';
part 'history_order_state.dart';
part 'history_order_bloc.freezed.dart';

class HistoryOrderBloc extends Bloc<HistoryOrderEvent, HistoryOrderState> {
  final OrderRemoteDatasource orderRemoteDatasource;
  HistoryOrderBloc(this.orderRemoteDatasource) : super(const _Initial()) {
    on<_GetAllOrder>((event, emit) async {
      emit(const _Loading());
      final result = await orderRemoteDatasource.getAllOrders();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
