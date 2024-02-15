part of 'top_rated_bloc.dart';

@freezed
class TopRatedState with _$TopRatedState {
  const factory TopRatedState.initial() = _Initial;
  const factory TopRatedState.loading() = _Loading;
  const factory TopRatedState.loaded(List<Product> products) = _Loaded;
  const factory TopRatedState.error(String message) = _Error;
}
