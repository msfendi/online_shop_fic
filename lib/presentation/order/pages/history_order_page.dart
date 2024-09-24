import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/components/spaces.dart';
import '../bloc/history_order/history_order_bloc.dart';
import '../models/transaction_model.dart';
import '../widgets/order_card.dart';

class HistoryOrderPage extends StatefulWidget {
  const HistoryOrderPage({super.key});

  @override
  State<HistoryOrderPage> createState() => _HistoryOrderPageState();
}

class _HistoryOrderPageState extends State<HistoryOrderPage> {
  @override
  void initState() {
    context.read<HistoryOrderBloc>().add(const HistoryOrderEvent.getAllOrder());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesanan'),
      ),
      body: BlocBuilder<HistoryOrderBloc, HistoryOrderState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const Text('No Data'),
            loading: () => const CircularProgressIndicator(),
            loaded: (orders) => ListView.separated(
              padding: const EdgeInsets.all(16.0),
              separatorBuilder: (context, index) => const SpaceHeight(16.0),
              itemCount: orders.data!.length,
              itemBuilder: (context, index) => OrderCard(
                data: orders.data![index],
              ),
            ),
          );
        },
      ),
    );
  }
}
