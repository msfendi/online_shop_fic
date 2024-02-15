import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:online_shop_fic/core/router/app_router.dart';

class SplashPages extends StatefulWidget {
  const SplashPages({Key? key}) : super(key: key);

  @override
  State<SplashPages> createState() => _SplashPagesState();
}

class _SplashPagesState extends State<SplashPages> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 3),
      () => context.goNamed(
        RouteConstants.root,
        pathParameters: PathParameters().toMap(),
      ),
    );

    return const Scaffold(
      body: Center(
        child: Text(
          'Splash Page',
          style: TextStyle(
              fontSize: 24, color: Colors.blue, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
