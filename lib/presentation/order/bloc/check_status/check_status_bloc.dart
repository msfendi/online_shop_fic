import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/datasource/order_remote_datasource.dart';

part 'check_status_event.dart';
part 'check_status_state.dart';
part 'check_status_bloc.freezed.dart';

class CheckStatusBloc extends Bloc<CheckStatusEvent, CheckStatusState> {
  final OrderRemoteDatasource _orderRemoteDatasource;
  CheckStatusBloc(this._orderRemoteDatasource) : super(const _Initial()) {
    on<_CheckStatus>((event, emit) async {
      emit(const _Loading());
      final result = await _orderRemoteDatasource.checkStatus(event.orderId);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
