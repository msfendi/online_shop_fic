part of 'order_bloc.dart';

@freezed
class OrderEvent with _$OrderEvent {
  const factory OrderEvent.started() = _Started;
  // Fungsi createOrder digunakan untuk membuat event dan mengirimkan parameter yang dibutuhkan untuk membuat request order
  const factory OrderEvent.createOrder({
    required int addressId,
    required String paymentMethod,
    required String paymentVaName,
    required String shippingService,
    required int shippingCost,
    required List<ProductQuantityModel> products,
  }) = _CreateOrder;
}
