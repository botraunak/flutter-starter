import 'package:flutter_starter/pages/home/home.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  // Runs the authentication middle ware
  String? _runAuthMiddleware(context, state) {
    return null;
  }

  GoRouter getRouter() {
    return GoRouter(
      routes: [
        GoRoute(
          path: '/',
          redirect: _runAuthMiddleware,
          builder: (context, state) {
            return const HomePage();
          },
        ),
      ],
    );
  }
}
