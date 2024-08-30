import 'dart:developer';

import 'package:go_router/go_router.dart';

import '../auth/view/login_screen.dart';
import '../chat/view/chat_screen.dart';
import '../home_screen.dart';
import '../locale/first_launch_screen.dart';
import 'check_initialization.dart';

int selectedBottomNavIndex = 0;

List<String> bottomNavItems = [
  '/home',
  '/chat',
  '/profile',
];

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
        loggedIn = true; // 테스트용으로 강제 로그인 상태

        final isLoggingIn = state.matchedLocation == '/login';
        final isFirstLaunch = state.matchedLocation == '/firstLaunch';

        if (!loggedIn && !isLoggingIn) {
          return '/login';
        } else if (firstLaunch && !isFirstLaunch) {
          return '/firstLaunch';
        } else {
          return null; // 현재 경로 유지
        }
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(), // 기본 홈 화면
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
        GoRoute(
          path: '/chat',
          builder: (context, state) => const ChatScreen(),
        ),
        // 다른 라우트 정의...
      ],
    );
  }
}
