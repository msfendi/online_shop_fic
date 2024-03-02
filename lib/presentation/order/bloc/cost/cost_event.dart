part of 'cost_bloc.dart';

@freezed
class CostEvent with _$CostEvent {
  const factory CostEvent.started() = _Started;
  const factory CostEvent.getCost(
      String origin, String destination, String courier) = _GetCost;
}
