import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:online_shop_fic/presentation/auth/bloc/logout/logout_bloc.dart';

import '../../../core/components/buttons.dart';
import '../../../core/router/app_router.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Detail'),
      ),
      body: Center(
        child: BlocConsumer<LogoutBloc, LogoutState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              loaded: (message) {
                context.goNamed(
                  RouteConstants.root,
                  pathParameters: PathParameters().toMap(),
                );
              },
              error: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                  ),
                );
              },
            );
          },
          builder: (context, state) {
            return state.maybeMap(
              orElse: () => Button.filled(
                onPressed: () {
                  context.read<LogoutBloc>().add(
                        const LogoutEvent.logout(),
                      );
                },
                label: 'Logout',
              ),
              loading: (_) => const CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
