import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:badges/badges.dart' as badges;
import 'package:online_shop_fic/presentation/home/bloc/best_seller/best_seller_bloc.dart';
import 'package:online_shop_fic/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:online_shop_fic/presentation/home/bloc/new_arrival/new_arrival_bloc.dart';
import 'package:online_shop_fic/presentation/home/bloc/top_rated/top_rated_bloc.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/search_input.dart';
import '../../../core/components/spaces.dart';
import '../../../core/router/app_router.dart';
import '../bloc/all_product/all_product_bloc.dart';
import '../models/product_model.dart';
import '../models/store_model.dart';
// import '../widgets/banner_slider.dart';
import '../widgets/organism/menu_categories.dart';
import '../widgets/organism/product_list.dart';
import '../widgets/title_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController searchController;
  final List<ProductModel> newArrivals = [
    ProductModel(
      images: [
        Assets.images.products.sepatu.path,
        Assets.images.products.sepatu2.path,
        Assets.images.products.sepatu.path,
      ],
      name: 'Sepatu Nike',
      price: 2200000,
      stock: 20,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ',
      store: StoreModel(
        name: 'CWB Online Store',
        type: StoreEnum.officialStore,
        imageUrl: 'https://avatars.githubusercontent.com/u/534678?v=4',
      ),
    ),
    ProductModel(
      images: [
        Assets.images.products.sepatu2.path,
        Assets.images.products.sepatu.path,
        Assets.images.products.sepatu2.path,
      ],
      name: 'Sepatu Nike',
      price: 2200000,
      stock: 20,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ',
      store: StoreModel(
        name: 'CWB Online Store',
        type: StoreEnum.officialStore,
        imageUrl: 'https://avatars.githubusercontent.com/u/534678?v=4',
      ),
    ),
  ];
  final List<ProductModel> topRatedProducts = [
    ProductModel(
      images: [
        Assets.images.products.mac.path,
        Assets.images.products.mac2.path,
        Assets.images.products.mac.path,
      ],
      name: 'Macbook',
      price: 12220000,
      stock: 20,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ',
      store: StoreModel(
        name: 'CWB Online Store',
        type: StoreEnum.officialStore,
        imageUrl: 'https://avatars.githubusercontent.com/u/534678?v=4',
      ),
    ),
    ProductModel(
      images: [
        Assets.images.products.mac2.path,
        Assets.images.products.mac.path,
        Assets.images.products.mac2.path,
      ],
      name: 'Macbook',
      price: 12220000,
      stock: 20,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ',
      store: StoreModel(
        name: 'CWB Online Store',
        type: StoreEnum.officialStore,
        imageUrl: 'https://avatars.githubusercontent.com/u/534678?v=4',
      ),
    ),
  ];
  final List<ProductModel> specialOffers = [
    ProductModel(
      images: [
        Assets.images.products.mac.path,
        Assets.images.products.mac2.path,
        Assets.images.products.mac.path,
      ],
      name: 'Macbook',
      price: 12220000,
      stock: 20,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ',
      store: StoreModel(
        name: 'CWB Online Store',
        type: StoreEnum.officialStore,
        imageUrl: 'https://avatars.githubusercontent.com/u/534678?v=4',
      ),
    ),
    ProductModel(
      images: [
        Assets.images.products.mac2.path,
        Assets.images.products.mac.path,
        Assets.images.products.mac2.path,
      ],
      name: 'Macbook',
      price: 12220000,
      stock: 20,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ',
      store: StoreModel(
        name: 'CWB Online Store',
        type: StoreEnum.officialStore,
        imageUrl: 'https://avatars.githubusercontent.com/u/534678?v=4',
      ),
    ),
  ];
  final List<String> banners1 = [
    Assets.images.banner1.path,
    Assets.images.banner1.path,
  ];
  final List<String> banners2 = [
    Assets.images.banner2.path,
    Assets.images.banner2.path,
    Assets.images.banner2.path,
  ];

  @override
  void initState() {
    context.read<AllProductBloc>().add(const AllProductEvent.getProducts());
    context.read<BestSellerBloc>().add(const BestSellerEvent.getBestSeller());
    context.read<TopRatedBloc>().add(const TopRatedEvent.getTopRated());
    context.read<NewArrivalBloc>().add(const NewArrivalEvent.getNewArrival());
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cwb Store'),
        actions: [
          BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (context, state) {
              return state.maybeWhen(
                loaded: (cart) {
                  final totalItemCart = cart.fold<int>(0, (prev, element) {
                    return prev + element.quantity;
                  });
                  return (totalItemCart > 0)
                      ? badges.Badge(
                          badgeContent: Text(cart.length.toString(),
                              style: const TextStyle(color: Colors.white)),
                          child: IconButton(
                            onPressed: () {
                              context.goNamed(
                                RouteConstants.cart,
                                pathParameters: PathParameters().toMap(),
                              );
                            },
                            icon: Assets.icons.cart.svg(height: 24.0),
                          ),
                        )
                      : IconButton(
                          onPressed: () {
                            context.goNamed(
                              RouteConstants.cart,
                              pathParameters: PathParameters().toMap(),
                            );
                          },
                          icon: Assets.icons.cart.svg(height: 24.0),
                        );
                },
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
          IconButton(
            onPressed: () {},
            icon: Assets.icons.notification.svg(height: 24.0),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SearchInput(
            controller: searchController,
            onTap: () {
              context.pushReplacementNamed(
                RouteConstants.root,
                pathParameters: PathParameters(
                  rootTab: RootTab.explore,
                ).toMap(),
              );
            },
          ),
          // const SpaceHeight(16.0),
          // BannerSlider(items: banners1),
          const SpaceHeight(12.0),
          TitleContent(
            title: 'Categories',
            onSeeAllTap: () {},
          ),
          const SpaceHeight(12.0),
          const MenuCategories(),
          const SpaceHeight(50.0),
          BlocBuilder<AllProductBloc, AllProductState>(
            builder: (context, state) {
              return state.maybeWhen(
                loaded: (products) {
                  return ProductList(
                    title: 'Featured Product',
                    onSeeAllTap: () {},
                    items:
                        products.length > 2 ? products.sublist(0, 2) : products,
                  );
                },
                orElse: () => const SizedBox.shrink(),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (message) => Center(
                  child: Text(message),
                ),
              );
            },
          ),
          // const SpaceHeight(50.0),
          // BannerSlider(items: banners2),
          const SpaceHeight(28.0),
          BlocBuilder<BestSellerBloc, BestSellerState>(
            builder: (context, state) {
              return state.maybeWhen(
                loaded: (products) {
                  return ProductList(
                    title: 'Best Seller',
                    onSeeAllTap: () {},
                    items:
                        products.length > 2 ? products.sublist(0, 2) : products,
                  );
                },
                orElse: () => const SizedBox.shrink(),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (message) => Center(
                  child: Text(message),
                ),
              );
            },
          ),
          const SpaceHeight(50.0),
          BlocBuilder<NewArrivalBloc, NewArrivalState>(
            builder: (context, state) {
              return state.maybeWhen(
                loaded: (products) {
                  return ProductList(
                    title: 'New Arrival Product',
                    onSeeAllTap: () {},
                    items:
                        products.length > 2 ? products.sublist(0, 2) : products,
                  );
                },
                orElse: () => const SizedBox.shrink(),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (message) => Center(
                  child: Text(message),
                ),
              );
            },
          ),
          const SpaceHeight(50.0),
          BlocBuilder<TopRatedBloc, TopRatedState>(
            builder: (context, state) {
              return state.maybeWhen(
                loaded: (products) {
                  return ProductList(
                    title: 'Top Rated Product',
                    onSeeAllTap: () {},
                    items:
                        products.length > 2 ? products.sublist(0, 2) : products,
                  );
                },
                orElse: () => const SizedBox.shrink(),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (message) => Center(
                  child: Text(message),
                ),
              );
            },
          ),
          const SpaceHeight(50.0),
          // ProductList(
          //   title: 'Special Offers',
          //   onSeeAllTap: () {},
          //   items: specialOffers,
          // ),
        ],
      ),
    );
  }
}
