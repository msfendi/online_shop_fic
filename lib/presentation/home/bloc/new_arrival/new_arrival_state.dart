part of 'new_arrival_bloc.dart';

@freezed
class NewArrivalState with _$NewArrivalState {
  const factory NewArrivalState.initial() = _Initial;
  const factory NewArrivalState.loading() = _Loading;
  const factory NewArrivalState.loaded(List<Product> products) = _Loaded;
  const factory NewArrivalState.error(String message) = _Error;
}
