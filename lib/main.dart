import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop_fic/core/constants/colors.dart';
import 'package:online_shop_fic/core/router/app_router.dart';
import 'package:online_shop_fic/data/datasource/category_remote_datasource.dart';
import 'package:online_shop_fic/data/datasource/product_remote_datasource.dart';
import 'package:online_shop_fic/presentation/home/bloc/best_seller/best_seller_bloc.dart';
import 'package:online_shop_fic/presentation/home/bloc/category/category_bloc.dart';
import 'package:online_shop_fic/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:online_shop_fic/presentation/home/bloc/new_arrival/new_arrival_bloc.dart';
import 'package:online_shop_fic/presentation/home/bloc/top_rated/top_rated_bloc.dart';

import 'presentation/home/bloc/all_product/all_product_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    final router = appRouter.router;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CategoryBloc(CategoryRemoteDataSource()),
        ),
        BlocProvider(
          create: (context) => AllProductBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => BestSellerBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => TopRatedBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => NewArrivalBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => CheckoutBloc(),
        )
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          textTheme: GoogleFonts.dmSansTextTheme(
            Theme.of(context).textTheme,
          ),
          appBarTheme: AppBarTheme(
            color: AppColors.white,
            titleTextStyle: GoogleFonts.quicksand(
              color: AppColors.primary,
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            ),
            iconTheme: const IconThemeData(
              color: AppColors.black,
            ),
            centerTitle: true,
            shape: Border(
              bottom: BorderSide(
                color: AppColors.black.withOpacity(0.05),
              ),
            ),
          ),
        ),
        routerDelegate: router.routerDelegate,
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
      ),
    );
  }
}
