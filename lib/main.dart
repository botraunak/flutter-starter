import 'package:flutter/material.dart';
import 'package:flutter_starter/di/injection.dart';
import 'package:flutter_starter/pages/home/home.dart';
import 'package:flutter_starter/style/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencyGraph();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme,
      home: const HomePage(),
    );
  }
}
