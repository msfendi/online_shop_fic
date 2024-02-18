import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:online_shop_fic/presentation/home/models/product_quantity_model.dart';

import '../../../../data/models/responses/product_response_model.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';
part 'checkout_bloc.freezed.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(const _Loaded([])) {
    on<_AddItemToCart>((event, emit) {
      final currentState = state as _Loaded;
      // cek apakah ada item didalam keranjang, dan jika ada apakah item tersebut sama dengan yang akan ditambahkan
      if (currentState.productCheckout
          .any((element) => element.product.id == event.product.id)) {
        // jika ada, cari index ke berapa dari item tersebut
        final index = currentState.productCheckout
            .indexWhere((element) => element.product.id == event.product.id);
        // ambil item tersebut
        final item = currentState.productCheckout[index];
        // copy item tersebut dengan quantity ditambah 1
        final newItem = item.copyWith(quantity: item.quantity + 1);
        // copy list keranjang dengan item yang sudah diupdate
        final newItemsCheckout = currentState.productCheckout
            .map((e) => e == item ? newItem : e)
            .toList();
        emit(_Loaded(newItemsCheckout));
      } else {
        // jika tidak ada, tambahkan item baru dengan quantity 1
        final newItem = ProductQuantityModel(event.product, 1);
        // copy list keranjang dengan item yang sudah ditambahkan
        final newItemsCheckout = [...currentState.productCheckout, newItem];
        emit(_Loaded(newItemsCheckout));
      }
    });

    on<_RemoveItemFromCart>((event, emit) {
      final currentState = state as _Loaded;
      // cek apakah ada item didalam keranjang, dan jika ada apakah item tersebut sama dengan yang akan dihapus
      if (currentState.productCheckout
          .any((element) => element.product.id == event.product.id)) {
        // jika ada, cari index ke berapa dari item tersebut
        final index = currentState.productCheckout
            .indexWhere((element) => element.product.id == event.product.id);
        // ambil item tersebut
        final item = currentState.productCheckout[index];
        // jika quantity dari item tersebut lebih dari 1, maka kurangi quantitynya
        if (item.quantity > 1) {
          final newItem = item.copyWith(quantity: item.quantity - 1);
          final newItemsCheckout = currentState.productCheckout
              .map((e) => e == item ? newItem : e)
              .toList();
          emit(_Loaded(newItemsCheckout));
        } else {
          // jika quantity dari item tersebut hanya 1, maka hapus item tersebut dari keranjang
          final newItemsCheckout = currentState.productCheckout
              .where((element) => element.product.id != event.product.id)
              .toList();
          emit(_Loaded(newItemsCheckout));
        }
      }
    });
  }
}
