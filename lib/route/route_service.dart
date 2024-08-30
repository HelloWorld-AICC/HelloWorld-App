import 'dart:developer';

import 'package:go_router/go_router.dart';

import '../auth/view/login_screen.dart';
import '../home_screen.dart';
import '../intro/splash_screen.dart';
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
        final firstLaunch = await CheckInitialization.isFirstLaunch();
        log("[RouteService] firstLaunch: $firstLaunch");
        if (firstLaunch) {
          return '/firstLaunch';
        }

        final isInitialized = await CheckInitialization.performInitialization();
        log("[RouteService] isInitialized: $isInitialized");

        if (!isInitialized) {
          return '/splash';
        }

        final loggedIn = await isUserLoggedIn;
        log("[RouteService] firstLaunch: $firstLaunch, loggedIn: $loggedIn");

        if (!firstLaunch && !loggedIn) {
          return '/login';
        } else {
          return '/home';
        }
      },
      routes: [
        GoRoute(
          path: '/splash',
          builder: (context, state) => const SplashScreen(),
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
