import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:online_shop_fic/data/models/responses/order_response_model.dart';
import 'package:online_shop_fic/presentation/home/models/product_quantity_model.dart';

import '../../../../data/datasource/order_remote_datasource.dart';
import '../../../../data/models/requests/order_request_model.dart';

part 'order_event.dart';
part 'order_state.dart';
part 'order_bloc.freezed.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRemoteDatasource orderRemoteDatasource;
  OrderBloc(this.orderRemoteDatasource) : super(const _Initial()) {
    // ketika event _CreateOrder dipanggil, maka akan menjalankan fungsi createOrder dari orderRemoteDatasource dengan mengirimkan data orderRequest
    on<_CreateOrder>((event, emit) async {
      final response = await orderRemoteDatasource.createOrder(
        OrderRequest(
          addressId: event.addressId,
          paymentMethod: event.paymentMethod,
          paymentVaName: event.paymentVaName,
          shippingService: event.shippingService,
          shippingCost: event.shippingCost,
          subtotal: 0,
          totalPrice: 0,
          // mengubah list productQuantityModel menjadi list item yang hanya berisi productId dan quantity sesuai pada backend
          items: event.products
              .map((e) => Item(productId: e.product.id, quantity: e.quantity))
              .toList(),
        ),
      );

      response.fold(
        (l) => emit(OrderState.error(message: l)),
        (r) => emit(OrderState.loaded(r)),
      );
    });
  }
}
