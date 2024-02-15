part of 'checkout_bloc.dart';

@freezed
class CheckoutEvent with _$CheckoutEvent {
  const factory CheckoutEvent.started() = _Started;
  const factory CheckoutEvent.addItemToCart(Product product) = _AddItemToCart;
  const factory CheckoutEvent.removeItemFromCart(Product product) =
      _RemoveItemFromCart;
}
