import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world_mvp/mypage/account/presentation/account_screen.dart';
import 'package:hello_world_mvp/mypage/privacy_policy/presentation/privacy_policy_screen.dart';
import 'package:hello_world_mvp/mypage/term/presentation/term_screen.dart';
import 'package:hello_world_mvp/mypage/withdraw/presentation/withdraw_screen.dart';
import 'package:hello_world_mvp/center/presentation/center_screen.dart';
import 'package:injectable/injectable.dart';

import '../../auth/application/status/auth_status_bloc.dart';
import '../../auth/presentation/login_screen.dart';
import '../../home/presentation/home_page.dart';
import '../../init/application/app_init_bloc.dart';
import '../../init/presentation/splash_page.dart';
import '../../init/presentation/terms_of_service_page.dart';
import '../../mypage/edit_profile/presentation/edit_profile_screen.dart';
import '../../mypage/menu/presentation/mypage_menu_screen.dart';
import '../../new_chat/presentation/new_chat_page.dart';
import '../application/bloc_refresh_notifier.dart';

@LazySingleton()
@Injectable()
class RouteService {
  late final GoRouter router;

  bool _hasRedirected = false;

  RouteService() {
    // blocRefreshNotifier = BlocRefreshNotifier(authStatusBloc.stream);
    // print('RouteService :: Stream has been initialized');

    router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const Placeholder(),
        ),
        GoRoute(
          path: '/splash',
          builder: (context, state) => SplashPage(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/chat',
          builder: (context, state) => NewChatPage(),
        ),
        GoRoute(
          path: '/mypage-menu',
          builder: (context, state) => const MypageMenuScreen(),
        ),
        GoRoute(
          path: '/edit-profile',
          builder: (context, state) => const EditProfileScreen(),
        ),
        GoRoute(
          path: '/terms-of-service',
          builder: (context, state) => TermsOfServicePage(),
        ),
        GoRoute(
          path: '/center',
          builder: (context, state) => CenterScreen(),
        )
      ],
      redirect: (context, state) {
        final isFirstRun = context.read<AppInitBloc>().state.isFirstRun;
        final isSignedIn = context.read<AuthStatusBloc>().state.isSignedIn;
        final isSplashComplete =
            context.read<AppInitBloc>().state.isSplashComplete;

        print(
            'Redirected, hasRedirected: $_hasRedirected, isFirstRun: $isFirstRun, isSignedIn: $isSignedIn, isSplashComplete: $isSplashComplete');

        if (_hasRedirected &&
            !isFirstRun &&
            isSplashComplete &&
            isSignedIn == null) return '/login';
        if (_hasRedirected) return null;

        if (isSignedIn == null) {
          _hasRedirected = true;
          return isFirstRun ? '/splash' : '/login';
        }

        if (isSignedIn) {
          _hasRedirected = true;
          return isFirstRun ? '/splash' : '/home';
        } else {
          _hasRedirected = true;
          return '/login';
        }
      },
      // refreshListenable: blocRefreshNotifier,
    );
    // blocRefreshNotifier.cancelSubscription();
  }

  void redirectToLoginPage() {
    router.go('/login');
  }

  void redirectToHomePage() {
    router.go('/home');
  }
}
