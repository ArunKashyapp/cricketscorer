
import 'package:cricket/router.dart';
import 'package:cricket/theme/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

void main(List<String> args) {
  runApp(const ProviderScope(child:  CricketApp()));
}

class CricketApp extends StatelessWidget {
  const CricketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: RoutemasterDelegate(
        routesBuilder: (context) {
          return newRoute;
        },
      ),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: ColorConstant.green600,
        useMaterial3: true,
      ),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}
