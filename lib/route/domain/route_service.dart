import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world_mvp/center/presentation/center_screen.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../auth/application/status/auth_status_bloc.dart';
import '../../auth/presentation/login_screen.dart';
import '../../community/board/presentation/community_board.dart';
import '../../community/create_post/presentation/create_post_page.dart';
import '../../community/post_detail/presentation/post_detail_page.dart';
import '../../home/presentation/home_page.dart';
import '../../init/application/app_init_bloc.dart';
import '../../init/presentation/splash_page.dart';
import '../../init/presentation/terms_of_service_page.dart';
import '../../mypage/edit_profile/presentation/edit_profile_screen.dart';
import '../../mypage/menu/presentation/mypage_menu_screen.dart';
import '../../new_chat/presentation/new_chat_page.dart';
import '../application/route_bloc.dart';
import 'custom_navigator_observer.dart';

@LazySingleton()
@Injectable()
class RouteService {
  late final GoRouter router;
  final RouteBloc routeBloc;

  RouteService({required this.routeBloc}) {
    router = GoRouter(initialLocation: '/', routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          print("Initial Route Called");
          return FutureBuilder<bool>(
            future: _markAppRunnedBefore(),
            builder: (context, snapshot) {
              bool isFirstRun = snapshot.data ?? true;
              bool isSignedIn =
                  context.read<AuthStatusBloc>().state.isSignedIn ?? false;

              print(
                  'isFirstRun: $isFirstRun, isSignedIn: $isSignedIn.. in Initial Route');
              if (!isFirstRun && isSignedIn) {
                return HomePage();
              } else if (!isFirstRun && !isSignedIn) {
                return LoginScreen();
              } else {
                return SplashPage();
              }
            },
          );
        },
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
      ),
      GoRoute(
        path: '/community',
        builder: (context, state) => CommunityBoard(),
      ),
      GoRoute(
          path: '/community/create-post',
          builder: (context, state) => CreatePostPage()),
      GoRoute(
        name: 'post-detail',
        path: '/post-detail/:category_id/:post_id',
        builder: (context, state) {
          final categoryId = state.pathParameters['category_id']!;
          final postId = state.pathParameters['post_id']!;

          return PostDetailPage(
            categoryId: int.parse(categoryId),
            postId: int.parse(postId),
          );
        },
      )
    ], observers: [
      CustomNavigatorObserver(routeBloc),
    ]);
  }

  void redirectToLoginPage() {
    router.go('/login');
  }

  void redirectToHomePage() {
    router.go('/home');
  }

  Future<bool> _markAppRunnedBefore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isFirstRun') ?? false;
  }
}
