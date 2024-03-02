part of 'checkout_bloc.dart';

@freezed
class CheckoutState with _$CheckoutState {
  const factory CheckoutState.initial() = _Initial;
  const factory CheckoutState.loading() = _Loading;
  // "address_id" : 7,
  //   "payment_method" : "bank_transfer",
  //   "payment_va_name" : "bri",
  //   "shipping_service" : "jne",
  //   "shipping_cost" : 20000,
  const factory CheckoutState.loaded(
      List<ProductQuantityModel> productCheckout,
      int addressId,
      String paymentMethod,
      String paymentVaName,
      String shippingService,
      int shippingCost) = _Loaded;
  const factory CheckoutState.error() = _Error;
}
