import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
// import 'package:online_shop_fic/data/models/requests/order_request_model.dart';
import 'package:online_shop_fic/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:online_shop_fic/presentation/order/bloc/order/order_bloc.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../../../core/core.dart';
import '../../../core/router/app_router.dart';
import '../../home/models/product_quantity_model.dart';
import '../models/bank_account_model.dart';
import '../widgets/countdown_timer.dart';
import '../widgets/payment_method.dart';

class PaymentDetailPage extends StatelessWidget {
  const PaymentDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final selectedPayment = ValueNotifier<int>(0);

    List<BankAccountModel> banksLimit = [banks[0], banks[1]];

    void seeAllTap() {
      showModalBottomSheet(
        context: context,
        useSafeArea: true,
        isScrollControlled: true,
        backgroundColor: AppColors.white,
        builder: (BuildContext context) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  child: ColoredBox(
                    color: AppColors.light,
                    child: SizedBox(height: 8.0, width: 55.0),
                  ),
                ),
                const SpaceHeight(20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Metode Pembayaran',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: AppColors.light,
                      child: IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(
                          Icons.close,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SpaceHeight(16.0),
                BlocBuilder<CheckoutBloc, CheckoutState>(
                  builder: (context, state) {
                    final paymentVaName = state.maybeWhen(
                      orElse: () => '',
                      loaded: (_, __, ___, paymentVaName, _____, ______) =>
                          paymentVaName,
                    );
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => PaymentMethod(
                        isActive: paymentVaName == banks[index].code,
                        data: banks[index],
                        onTap: () {
                          context.read<CheckoutBloc>().add(
                                CheckoutEvent.addPaymentVaName(
                                  banks[index].code,
                                ),
                              );
                          if (banksLimit.first != banks[index]) {
                            banksLimit[1] = banks[index];
                          }
                          context.pop();
                        },
                      ),
                      separatorBuilder: (context, index) =>
                          const SpaceHeight(14.0),
                      itemCount: banks.length,
                    );
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    void buyNowTap() {
      showModalBottomSheet(
        context: context,
        useSafeArea: true,
        isScrollControlled: true,
        backgroundColor: AppColors.white,
        builder: (BuildContext context) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  child: ColoredBox(
                    color: AppColors.light,
                    child: SizedBox(height: 8.0, width: 55.0),
                  ),
                ),
                const SpaceHeight(20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Pesananmu dalam Proses',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: AppColors.light,
                      child: IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(
                          Icons.close,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SpaceHeight(20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Assets.images.processOrder.image(),
                ),
                const SpaceHeight(50.0),
                Row(
                  children: [
                    Flexible(
                      child: Button.outlined(
                        onPressed: () {
                          context.goNamed(
                            RouteConstants.trackingOrder,
                            pathParameters: PathParameters().toMap(),
                          );
                        },
                        label: 'Lacak Pesanan',
                      ),
                    ),
                    const SpaceWidth(20.0),
                    Flexible(
                      child: Button.filled(
                        onPressed: () {
                          context.goNamed(
                            RouteConstants.root,
                            pathParameters: PathParameters().toMap(),
                          );
                        },
                        label: 'Back to Home',
                      ),
                    ),
                  ],
                ),
                const SpaceHeight(20.0),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Row(
            children: [
              const Icon(Icons.schedule),
              const SpaceWidth(12.0),
              const Flexible(
                child: Text(
                  'Selesaikan Pembayaran Dalam',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SpaceWidth(12.0),
              CountdownTimer(
                minute: 120,
                onTimerCompletion: () {},
              ),
            ],
          ),
          const SpaceHeight(30.0),
          Row(
            children: [
              const Text(
                'Metode Pembayaran',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: seeAllTap,
                child: const Text(
                  'Lihat semua',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SpaceHeight(20.0),
          BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (context, state) {
              final paymentVaName = state.maybeWhen(
                orElse: () => '',
                loaded: (_, __, ___, paymentVaName, _____, ______) =>
                    paymentVaName,
              );
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => PaymentMethod(
                    isActive: paymentVaName == banksLimit[index].code,
                    data: banksLimit[index],
                    onTap: () {
                      context.read<CheckoutBloc>().add(
                            CheckoutEvent.addPaymentVaName(
                              banksLimit[index].code,
                            ),
                          );
                    }),
                separatorBuilder: (context, index) => const SpaceHeight(14.0),
                itemCount: banksLimit.length,
              );
            },
          ),
          const SpaceHeight(36.0),
          const Divider(),
          const SpaceHeight(8.0),
          const Text(
            'Ringkasan Pembayaran',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SpaceHeight(12.0),
          Row(
            children: [
              const Text(
                'Total Belanja',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              BlocBuilder<CheckoutBloc, CheckoutState>(
                builder: (context, state) {
                  final totalShipping = state.maybeWhen(
                    orElse: () => 0,
                    loaded: (checkout, _, __, ___, ____, _____) {
                      return checkout.fold<int>(0, (prev, element) {
                        return prev +
                            (element.product.price! * element.quantity);
                      });
                    },
                  );
                  return Text(
                    totalShipping.currencyFormatRp,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),
            ],
          ),
          const SpaceHeight(5.0),
          Row(
            children: [
              const Text(
                'Biaya Pengiriman',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              BlocBuilder<CheckoutBloc, CheckoutState>(
                builder: (context, state) {
                  final shippingCost = state.maybeWhen(
                      orElse: () => 0,
                      loaded: (checkout, _, __, ___, ____, shippingCost) =>
                          shippingCost);
                  return Text(
                    shippingCost.currencyFormatRp,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),
            ],
          ),
          const SpaceHeight(8.0),
          const Divider(),
          const SpaceHeight(24.0),
          Row(
            children: [
              const Text(
                'Total Tagihan',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              BlocBuilder<CheckoutBloc, CheckoutState>(
                builder: (context, state) {
                  final totalShipping = state.maybeWhen(
                    orElse: () => 0,
                    loaded: (checkout, _, __, ___, ____, shippingCost) {
                      return checkout.fold<int>(0, (prev, element) {
                            return prev +
                                (element.product.price! * element.quantity);
                          }) +
                          shippingCost;
                    },
                  );
                  return Text(
                    totalShipping.currencyFormatRp,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),
            ],
          ),
          const SpaceHeight(20.0),
          BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (context, state) {
              final paymentVaName = state.maybeWhen(
                orElse: () => '',
                loaded: (_, __, ___, paymentVaName, _____, ______) =>
                    paymentVaName,
              );
              final addressId = state.maybeWhen(
                orElse: () => 0,
                loaded: (__, addressId, ___, ____, _____, ______) => addressId,
              );
              final paymentMethod = state.maybeWhen(
                orElse: () => '',
                loaded: (_, __, paymentMethod, ____, _____, ______) =>
                    paymentMethod,
              );
              final shippingService = state.maybeWhen(
                orElse: () => '',
                loaded: (_, __, ___, ____, shippingService, ______) =>
                    shippingService,
              );
              final shippingCost = state.maybeWhen(
                orElse: () => 0,
                loaded: (_, __, ___, ____, _____, shippingCost) => shippingCost,
              );
              final products = state.maybeWhen(
                  orElse: () => [],
                  loaded: (products, __, ___, ____, _____, ______) => products);

              return BlocListener<OrderBloc, OrderState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {},
                    loaded: (response) {
                      context.pushNamed(
                        RouteConstants.paymentWaiting,
                        pathParameters: PathParameters().toMap(),
                        extra: response.data!.id,
                      );
                    },
                    error: (message) =>
                        ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text(message),
                      ),
                    ),
                  );
                },
                child: Button.filled(
                  disabled: paymentVaName == '',
                  onPressed: () {
                    context.read<OrderBloc>().add(OrderEvent.createOrder(
                        addressId: addressId,
                        paymentMethod: paymentMethod,
                        paymentVaName: paymentVaName,
                        shippingService: shippingService,
                        shippingCost: shippingCost,
                        products: products as List<ProductQuantityModel>));
                  },
                  label: 'Bayar Sekarang',
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}