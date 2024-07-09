import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter/auth/bloc/auth_bloc.dart';
import 'package:go_router/go_router.dart';

class AuthRouteWrapper extends StatelessWidget {
  const AuthRouteWrapper({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) {
        return ModalRoute.of(context)?.isActive ?? false;
      },
      listener: (context, state) {
        state.when(
          signedOut: () {
            context.go('/');
          },
          signedIn: (user) {
            context.go('/');
          },
        );
      },
      child: child,
    );
  }
}
