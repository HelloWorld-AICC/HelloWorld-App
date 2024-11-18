import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
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
  final AppInitBloc appInitBloc;
  final AuthStatusBloc authStatusBloc;

  late final GoRouter router;

  bool _hasRedirected = false;

  RouteService(this.appInitBloc, this.authStatusBloc) {
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
      ],
      redirect: (context, state) {
        final isFirstRun = appInitBloc.state.isFirstRun;
        final isSignedIn = authStatusBloc.state.isSignedIn;
        print(
            'Redirected, hasRedirected: $_hasRedirected, isFirstRun: $isFirstRun, isSignedIn: $isSignedIn');
        
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
      refreshListenable: BlocRefreshNotifier(authStatusBloc.stream),
    );
  }
}
