// ignore_for_file: unused_import, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:online_shop_fic/core/extensions/int_ext.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/buttons.dart';
import '../../../core/components/components.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import '../../../core/router/app_router.dart';
import '../../home/bloc/checkout/checkout_bloc.dart';
import '../../home/models/product_model.dart';
import '../../home/models/store_model.dart';
import '../bloc/cost/cost_bloc.dart';
import '../models/shipping_model.dart';
import '../widgets/cart_tile.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

var selectedCourier = '';

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    final couriers = <String>[
      'jne',
      'pos',
      'tiki',
      'rpx',
      'pandu',
      'wahana',
      'sicepat',
      'jnt',
      'pahala',
      'sap',
      'jet',
      'indah',
      'dse',
      'slis',
      'first',
      'ncs',
      'star',
      'ninja',
      'lion',
      'idl',
      'rex',
      'ide',
      'sentral',
      'anteraja',
      'jtl'
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Orders'),
        actions: [
          IconButton(
            onPressed: () {
              context.goNamed(
                RouteConstants.cart,
                pathParameters: PathParameters(
                  rootTab: RootTab.order,
                ).toMap(),
              );
            },
            icon: Assets.icons.cart.svg(height: 24.0),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (context, state) {
              return state.maybeWhen(
                  orElse: () => const SizedBox.shrink(),
                  loaded: (checkout, _, __, ___, ____, _____) {
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: checkout.isNotEmpty ? checkout.length : 0,
                      itemBuilder: (context, index) => CartTile(
                        data: checkout[index],
                      ),
                      separatorBuilder: (context, index) =>
                          const SpaceHeight(16.0),
                    );
                  });
            },
          ),
          const SpaceHeight(36.0),
          CustomDropdown<String>(
            value: couriers.first,
            items: couriers,
            label: 'Pilih Kurir Pengiriman',
            onChanged: (value) {
              setState(() {
                selectedCourier = value!;
              });
            },
          ),
          const SpaceHeight(36.0),
          const _SelectShipping(),
          // const _ShippingSelected(),
          const SpaceHeight(36.0),
          const Divider(),
          const SpaceHeight(8.0),
          const Text(
            'Detail Belanja :',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SpaceHeight(12.0),
          Row(
            children: [
              const Text(
                'Total Harga (Produk)',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              BlocBuilder<CheckoutBloc, CheckoutState>(
                builder: (context, state) {
                  final total = state.maybeWhen(
                    orElse: () => 0,
                    loaded: (checkout, _, __, ___, ____, _____) {
                      return checkout.fold<int>(0, (prev, element) {
                        return prev +
                            (element.product.price! * element.quantity);
                      });
                    },
                  );
                  return Text(
                    total.currencyFormatRp,
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
                'Total Ongkos Kirim',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              BlocBuilder<CheckoutBloc, CheckoutState>(
                builder: (context, state) {
                  final totalShippingCost = state.maybeWhen(
                    orElse: () => 0,
                    loaded: (_, __, ___, ____, _____, shippingCost) {
                      return shippingCost;
                    },
                  );
                  return Text(
                    totalShippingCost.currencyFormatRp,
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
              final shippingService = state.maybeWhen(
                orElse: () => '',
                loaded: (_, __, ___, ____, shippingService, _____) =>
                    shippingService,
              );
              return Button.filled(
                disabled: shippingService == '',
                onPressed: () {
                  context.goNamed(
                    RouteConstants.paymentDetail,
                    pathParameters: PathParameters().toMap(),
                  );
                },
                label: 'Pilih Pembayaran',
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SelectShipping extends StatelessWidget {
  const _SelectShipping();

  @override
  Widget build(BuildContext context) {
    final selectedPayment = ValueNotifier<int>(0);
    void onSelectShippingTap() {
      context
          .read<CostBloc>()
          .add(CostEvent.getCost('3126', '574', selectedCourier));
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                    child: ColoredBox(
                      color: AppColors.light,
                      child: SizedBox(height: 8.0, width: 55.0),
                    ),
                  ),
                ),
                const SpaceHeight(20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Metode Pengiriman',
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
                const SpaceHeight(18.0),
                Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 1.50,
                        color: AppColors.stroke,
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: ListTile(
                    leading: Assets.icons.routing.svg(),
                    subtitle: const Text('Dikirim dari Kabupaten Banyuwangi'),
                    trailing: const Text(
                      'berat: 1kg',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SpaceHeight(12.0),
                const Text(
                  'Estimasi tiba 20 - 23 Januari (Rp. 20.000)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SpaceHeight(30.0),
                const Divider(color: AppColors.stroke),
                BlocBuilder<CostBloc, CostState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () => const SizedBox.shrink(),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      loaded: (costResponse) {
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final item = costResponse
                                .rajaongkir?.results![0].costs![index];
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              onTap: () {
                                selectedPayment.value = index;
                                context.read<CheckoutBloc>().add(
                                    CheckoutEvent.addShippingService(
                                        selectedCourier,
                                        item!.cost![0].value!));
                                context.pop();
                              },
                              title: Text(
                                  '${item!.service} - ${item.description} (${item.cost![0].value!.currencyFormatRp})'),
                              subtitle: Text(
                                  'Estimasi tiba ${item.cost![0].etd} hari'),
                              trailing: Radio<int>(
                                value: index,
                                groupValue: selectedPayment.value,
                                onChanged: (value) {
                                  selectedPayment.value = value!;
                                },
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const Divider(color: AppColors.stroke),
                          itemCount: costResponse
                              .rajaongkir!.results![0].costs!.length,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    return GestureDetector(
      onTap: onSelectShippingTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 20.0),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.stroke),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Pilih Pengiriman',
              style: TextStyle(fontSize: 16),
            ),
            Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
