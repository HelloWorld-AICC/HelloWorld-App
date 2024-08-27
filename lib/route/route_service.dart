import 'package:go_router/go_router.dart';

class RouteService {
  final bool isFirstLaunch;

  RouteService({
    required this.isFirstLaunch,
  });

  GoRouter get router {
    return GoRouter(
      initialLocation: _initialRoute(),
      routes: [
        GoRoute(
          path: '/firstLaunch',
          builder: (context, state) => FirstLaunchScreen(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => HomeScreen(),
        ),
      ],
    );
  }

  String _initialRoute() {
    if (isFirstLaunch) {
      return '/firstLaunch';
    } else {
      return '/home';
    }
  }
}
