part of 'new_arrival_bloc.dart';

@freezed
class NewArrivalEvent with _$NewArrivalEvent {
  const factory NewArrivalEvent.started() = _Started;
  const factory NewArrivalEvent.getNewArrival() = _GetNewArrival;
}
