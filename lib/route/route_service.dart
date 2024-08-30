import 'dart:developer';

import 'package:go_router/go_router.dart';

import '../auth/view/login_screen.dart';
import '../home_screen.dart';
import '../locale/first_launch_screen.dart';
import 'check_initialization.dart';

class RouteService {
  final Future<bool> isUserLoggedIn;

  RouteService({
    required this.isUserLoggedIn,
  });

  GoRouter get router {
    return GoRouter(
      redirect: (context, state) async {
        final firstLaunch = await CheckInitialization.performInitialization();
        log("[RouteService] firstLaunch: $firstLaunch");

        var loggedIn = await isUserLoggedIn;
        loggedIn = true;
        log("[RouteService] firstLaunch: $firstLaunch, loggedIn: $loggedIn");

        if (!loggedIn) {
          return '/login';
        } else {
          return '/home';
        }
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const FirstLaunchScreen(),
        ),
        GoRoute(
          path: '/firstLaunch',
          builder: (context, state) => const FirstLaunchScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),
      ],
    );
  }
}
