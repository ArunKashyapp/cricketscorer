import 'package:cricket/features/add_team/screen/add_team.dart';
import 'package:cricket/features/overs/screen/overs_screen.dart';
import 'package:cricket/features/toss/screen/toss_screen.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

final newRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(
        child: AddTeam(),
      ),
  '/toss-screen': (routeData) {
    final teamName1 = routeData.queryParameters['teamName1'];
    final teamName2 = routeData.queryParameters['teamName2'];
    return MaterialPage(
      child: TossScreen(teamName1: teamName1!, teamName2: teamName2!),
    );
  },
  '/over-screen': (_) {
    return const MaterialPage(child: OverScreen());
  }
});
