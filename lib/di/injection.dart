import 'package:flutter_starter/router/app_router.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyGraph() async {
  getIt.registerFactory(AppRouter.new);
}
