import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/components/components.dart';
import '../../../core/router/app_router.dart';
import '../../auth/bloc/logout/logout_bloc.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
