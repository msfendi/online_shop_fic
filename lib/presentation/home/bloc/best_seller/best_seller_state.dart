part of 'best_seller_bloc.dart';

@freezed
class BestSellerState with _$BestSellerState {
  const factory BestSellerState.initial() = _Initial;
  const factory BestSellerState.loading() = _Loading;
  const factory BestSellerState.loaded(List<Product> products) = _Loaded;
  const factory BestSellerState.error(String message) = _Error;
}
