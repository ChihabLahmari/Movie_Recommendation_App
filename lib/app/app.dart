import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_clean_architecture_mvvm/presentation/resources/routes_manager.dart';

class MyApp extends StatefulWidget {
  // defualt constructor
  // const MyApp({super.key});

  // named constructor
  const MyApp._internal();

  static const MyApp _instance = MyApp._internal(); // singleton or single instance
  // singleton : ydir instance frd w7da w tb9a t5dm biha dima
  // factory : kol mra t3ytlo ydir instance jdida
  factory MyApp() => _instance; // factory

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      // theme: getApplicationTheme(),
    );
  }
}
