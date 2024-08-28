import 'package:go_router/go_router.dart';

import '../auth/view/login_screen.dart';
import '../home_screen.dart';
import '../intro/first_launch_screen.dart';
import '../splash_screen.dart';
import 'check_initialization.dart';

class RouteService {
  final Future<bool> isUserLoggedIn;

  RouteService({
    required this.isUserLoggedIn,
  });

  GoRouter get router {
    return GoRouter(
      redirect: (context, state) async {
        final isInitialized = await CheckInitialization.performInitialization();

        if (!isInitialized) {
          return '/splash';
        }

        final firstLaunch = await CheckInitialization.performInitialization();
        final loggedIn = await isUserLoggedIn;

        if (firstLaunch) {
          return '/firstLaunch';
        } else if (!loggedIn) {
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
