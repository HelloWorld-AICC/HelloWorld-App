import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../home_screen.dart';

class RouteService {
  // GoRouter getter
  GoRouter get router {
    return GoRouter(
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) =>
              const HomeScreen(),
        ),
        GoRoute(
          path: '/chat',
          builder: (BuildContext context, GoRouterState state) =>
              const HomeScreen(),
        ),
      ],
    );
  }
}
