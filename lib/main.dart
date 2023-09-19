import 'package:cricket/features/add_team/screen/add_team.dart';
import 'package:cricket/theme/color_constant.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const CricketApp());
}

class CricketApp extends StatelessWidget {
  const CricketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: ColorConstant.green600,
        useMaterial3: true,
      ),
      home: const AddTeam(),
    );
  }
}
