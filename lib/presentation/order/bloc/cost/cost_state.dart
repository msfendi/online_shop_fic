part of 'cost_bloc.dart';

@freezed
class CostState with _$CostState {
  const factory CostState.initial() = _Initial;
  const factory CostState.loading() = _Loading;
  const factory CostState.loaded(CostResponse costResponse) = _Loaded;
  const factory CostState.error(String message) = _Error;
}
