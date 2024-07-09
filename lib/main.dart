import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/common/constants.dart';
import 'package:flutter_starter/di/injection.dart';
import 'package:flutter_starter/firebase_options.dart';
import 'package:flutter_starter/router/app_router.dart';
import 'package:flutter_starter/style/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupDependencyGraph();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = getIt<AppRouter>().getRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: appName,
      theme: appTheme,
      routerConfig: _appRouter,
    );
  }
}
