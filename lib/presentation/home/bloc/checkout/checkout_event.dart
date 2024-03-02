part of 'checkout_bloc.dart';

@freezed
class CheckoutEvent with _$CheckoutEvent {
  const factory CheckoutEvent.started() = _Started;
  const factory CheckoutEvent.addItemToCart(Product product) = _AddItemToCart;
  const factory CheckoutEvent.removeItemFromCart(Product product) =
      _RemoveItemFromCart;

  // add address id
  const factory CheckoutEvent.addAddressId(int addressId) = _AddAddressId;
  // add payment method
  const factory CheckoutEvent.addPaymentMethod(String paymentMethod) =
      _AddPaymentMethod;
  // add payment va name
  const factory CheckoutEvent.addPaymentVaName(String paymentVaName) =
      _AddPaymentVaName;
  // add shipping service
  const factory CheckoutEvent.addShippingService(
      String shippingService, int shippingCost) = _AddShippingService;
}
