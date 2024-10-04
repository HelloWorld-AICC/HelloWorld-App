import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:hello_world_mvp/new_chat/presentation/new_chat_page.dart';

import '../home/presentation/home_screen.dart';

class RouteService {
  // GoRouter getter
  GoRouter get router {
    return GoRouter(
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) =>
              const HomePage(),
        ),
        GoRoute(
          path: '/chat',
          builder: (BuildContext context, GoRouterState state) => NewChatPage(),
        ),
      ],
    );
  }
}
