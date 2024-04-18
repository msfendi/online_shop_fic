part of 'order_bloc.dart';

@freezed
class OrderState with _$OrderState {
  const factory OrderState.initial() = _Initial;
  const factory OrderState.loading() = _Loading;
  // Fungsi loaded digunakan untuk membuat state loaded dengan parameter data bertipe OrderResponse
  const factory OrderState.loaded(OrderResponse data) = _Loaded;
  const factory OrderState.error({required String message}) = _Error;
}
