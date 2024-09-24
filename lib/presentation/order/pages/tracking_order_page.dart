// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../../../core/core.dart';
import '../../../core/router/app_router.dart';
import '../../home/models/product_model.dart';
import '../../home/models/store_model.dart';
import '../bloc/order_detail/order_detail_bloc.dart';
import '../models/track_record_model.dart';
import '../widgets/product_tile.dart';
import '../widgets/tracking_horizontal.dart';

class TrackingOrderPage extends StatefulWidget {
  int orderId;
  TrackingOrderPage({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  @override
  State<TrackingOrderPage> createState() => _TrackingOrderPageState();
}

class _TrackingOrderPageState extends State<TrackingOrderPage> {
  @override
  void initState() {
    context
        .read<OrderDetailBloc>()
        .add(OrderDetailEvent.getOrderDetail(widget.orderId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<TrackRecordModel> trackRecords = [
      TrackRecordModel(
        title: 'Pesanan Anda belum dibayar',
        status: TrackRecordStatus.belumBayar,
        isActive: true,
        updatedAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
      TrackRecordModel(
        title: 'Pesanan Anda sedang disiapkan',
        status: TrackRecordStatus.dikemas,
        isActive: true,
        updatedAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      TrackRecordModel(
        title: 'Pesanan Anda dalam pengiriman',
        status: TrackRecordStatus.dikirim,
        isActive: true,
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      TrackRecordModel(
        title: 'Pesanan Anda telah tiba',
        status: TrackRecordStatus.selesai,
        isActive: true,
        updatedAt: DateTime.now(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Orders'),
      ),
      body: BlocBuilder<OrderDetailBloc, OrderDetailState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            loaded: (orderDetail) => ListView(
              padding: const EdgeInsets.all(20.0),
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: orderDetail.data!.orderItems!.length,
                  itemBuilder: (context, index) => ProductTile(
                    data: orderDetail.data!.orderItems![index],
                  ),
                  separatorBuilder: (context, index) => const SpaceHeight(16.0),
                ),
                const SpaceHeight(40.0),
                TrackingHorizontal(
                    trackRecords: trackRecords, orderDetail: orderDetail),
                // Button.outlined(
                //   onPressed: () {
                //     context.goNamed(
                //       RouteConstants.shippingDetail,
                //       pathParameters: PathParameters().toMap(),
                //       extra: orderDetail.data!.shippingResi,
                //     );
                //   },
                //   label: 'Detail pelacakan pengiriman',
                // ),
                const SpaceHeight(20.0),
                const Text(
                  'Info Pengiriman',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SpaceHeight(20.0),
                const Text(
                  'Alamat Pesanan',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  orderDetail.data!.address!.fullAddress!,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SpaceHeight(16.0),
                const Text(
                  'Penerima',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  orderDetail.data!.user!.name!,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
