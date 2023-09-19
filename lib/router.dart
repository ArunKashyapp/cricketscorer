import 'package:cricket/features/add_team/screen/add_team.dart';
import 'package:cricket/features/toss/screen/toss_screen.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

final newRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(
        child: AddTeam(),
      ),
  '/toss-screen': (_) => const MaterialPage(
        child: TossScreen(),
      ),
});
