import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../../../core/core.dart';
import '../../../core/router/app_router.dart';
import '../../../data/models/responses/address_response_model.dart';
import '../bloc/address/address_bloc.dart';
import '../widgets/address_tile.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<AddressBloc>().add(const AddressEvent.getAddress());
    super.initState();
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) {
      setState(() {
        context.read<AddressBloc>().add(const AddressEvent.getAddress());
      });
    }
    _refreshController.loadComplete();
  }

  Address address = Address(
    id: 0,
    name: '',
    districtId: '',
    fullAddress: '',
    cityId: '',
    provId: '',
    postalCode: '',
    phone: '',
    isDefault: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address'),
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
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        enablePullDown: true,
        // enablePullUp: true,
        header: const WaterDropMaterialHeader(),
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            const Text(
              'Pilih atau tambahkan alamat pengiriman',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SpaceHeight(20.0),
            BlocBuilder<AddressBloc, AddressState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      enabled: true,
                      child: AddressTile(
                          data: address, onTap: () {}, onEditTap: () {})),
                  loading: () => Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      enabled: true,
                      child: AddressTile(
                          data: address, onTap: () {}, onEditTap: () {})),
                  error: (message) => Center(
                    child: Text(message),
                  ),
                  loaded: (addresses) {
                    int selectedIndex = addresses
                        .indexWhere((element) => element.isDefault == 1);
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: addresses.length,
                      itemBuilder: (context, index) => AddressTile(
                        isSelected: selectedIndex == index,
                        data: addresses[index],
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        onEditTap: () {
                          context.goNamed(
                            RouteConstants.editAddress,
                            pathParameters: PathParameters(
                              rootTab: RootTab.order,
                            ).toMap(),
                            extra: addresses[index],
                          );
                        },
                      ),
                      separatorBuilder: (context, index) =>
                          const SpaceHeight(16.0),
                    );
                  },
                );
                // return ListView.separated(
                //   shrinkWrap: true,
                //   physics: const NeverScrollableScrollPhysics(),
                //   itemCount: addresses.length,
                //   itemBuilder: (context, index) => AddressTile(
                //     isSelected: selectedIndex == index,
                //     data: addresses[index],
                //     onTap: () {
                //       selectedIndex = index;
                //       setState(() {});
                //     },
                //     onEditTap: () {
                //       context.goNamed(
                //         RouteConstants.editAddress,
                //         pathParameters: PathParameters(
                //           rootTab: RootTab.order,
                //         ).toMap(),
                //         extra: addresses[index],
                //       );
                //     },
                //   ),
                //   separatorBuilder: (context, index) => const SpaceHeight(16.0),
                // );
              },
            ),
            const SpaceHeight(40.0),
            Button.outlined(
              onPressed: () {
                context.goNamed(
                  RouteConstants.addAddress,
                  pathParameters: PathParameters(
                    rootTab: RootTab.order,
                  ).toMap(),
                );
              },
              label: 'Add address',
            ),
            const SpaceHeight(50.0),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Subtotal (Estimasi)',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  20000.currencyFormatRp,
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            const SpaceHeight(12.0),
            Button.filled(
              onPressed: () {
                context.goNamed(
                  RouteConstants.orderDetail,
                  pathParameters: PathParameters(
                    rootTab: RootTab.order,
                  ).toMap(),
                );
              },
              label: 'Lanjutkan',
            ),
          ],
        ),
      ),
    );
  }
}
