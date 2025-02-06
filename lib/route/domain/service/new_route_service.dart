import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world_mvp/auth/application/status/auth_status_bloc.dart';
import 'package:hello_world_mvp/auth/presentation/login_screen.dart';
import 'package:hello_world_mvp/callbot/call_bot_screen.dart';
import 'package:hello_world_mvp/center/presentation/center_screen.dart';
import 'package:hello_world_mvp/community/board/presentation/community_board.dart';
import 'package:hello_world_mvp/community/create_post/presentation/create_post_page.dart';
import 'package:hello_world_mvp/community/post_detail/presentation/post_detail_page.dart';
import 'package:hello_world_mvp/home/presentation/home_page.dart';
import 'package:hello_world_mvp/init/presentation/splash_page.dart';
import 'package:hello_world_mvp/init/presentation/terms_of_service_page.dart';
import 'package:hello_world_mvp/mypage/account/presentation/account_screen.dart';
import 'package:hello_world_mvp/mypage/edit_profile/presentation/edit_profile_screen.dart';
import 'package:hello_world_mvp/mypage/menu/presentation/mypage_menu_screen.dart';
import 'package:hello_world_mvp/mypage/privacy_policy/presentation/privacy_policy_screen.dart';
import 'package:hello_world_mvp/mypage/withdraw/presentation/withdraw_screen.dart';
import 'package:hello_world_mvp/new_chat/presentation/new_chat_page.dart';
import 'package:hello_world_mvp/resume/resume_screen.dart';
import 'package:hello_world_mvp/route/path.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../application/route_bloc.dart';
import 'custom_navigator_observer.dart';

@LazySingleton()
@Injectable()
class RouteService {
  late final GoRouter router;
  final RouteBloc routeBloc;

  // Map of AppRoute to route path
  final Map<AppRoute, String> _routePaths = {
    AppRoute.splash: '/splash',
    AppRoute.home: '/home',
    AppRoute.login: '/login',
    AppRoute.chat: '/chat',
    AppRoute.mypageMenu: '/mypage-menu',
    AppRoute.editProfile: '/edit-profile',
    AppRoute.termsOfService: '/terms-of-service',
    AppRoute.center: '/center',
    AppRoute.consultationCenter: '/consultation_center',
    AppRoute.community: '/community',
    AppRoute.communityBoard: '/community/board',
    AppRoute.createPost: '/community/create-post',
    AppRoute.postDetail: '/post-detail/:category_id/:post_id',
    AppRoute.account: '/account',
    AppRoute.privacyPolicy: '/privacy-policy',
    AppRoute.resume: '/resume',
    AppRoute.callBot: '/callbot',
    AppRoute.withdraw: '/withdraw',
  };

  // Map of AppRoute to its respective widget builder
  final Map<AppRoute, Widget Function(BuildContext)> _routeBuilders = {
    AppRoute.splash: (context) => SplashPage(),
    AppRoute.home: (context) => const HomePage(),
    AppRoute.login: (context) => const LoginScreen(),
    AppRoute.chat: (context) => NewChatPage(),
    AppRoute.mypageMenu: (context) => const MypageMenuScreen(),
    AppRoute.editProfile: (context) => const EditProfileScreen(),
    AppRoute.termsOfService: (context) => TermsOfServicePage(),
    AppRoute.center: (context) => CenterScreen(),
    AppRoute.consultationCenter: (context) => CenterScreen(),
    AppRoute.community: (context) => CommunityBoard(),
    AppRoute.communityBoard: (context) => CommunityBoard(),
    AppRoute.createPost: (context) => CreatePostPage(),
    AppRoute.account: (context) => AccountScreen(),
    AppRoute.privacyPolicy: (context) => PrivacyPolicyScreen(),
    AppRoute.resume: (context) => const ResumeScreen(),
    AppRoute.callBot: (context) => const CallBotScreen(),
    AppRoute.withdraw: (context) => const WithdrawScreen(),
  };

  RouteService({required this.routeBloc}) {
    router = GoRouter(
      initialLocation: '/',
      routes: _getRoutes(),
      observers: [CustomNavigatorObserver(routeBloc)],
    );
  }

  List<GoRoute> _getRoutes() {
    // Using the routePaths map to generate routes dynamically
    return [
      GoRoute(
        path: '/',
        builder: _initialRouteBuilder,
      ),
      ..._routePaths.entries.map((entry) {
        return _buildRoute(entry.key, entry.value);
      }).toList(),
      GoRoute(
        name: AppRoute.postDetail.name,
        path: '/post-detail/:category_id/:post_id',
        builder: _postDetailPageBuilder,
      ),
    ];
  }

  // Build routes dynamically based on the route map
  GoRoute _buildRoute(AppRoute route, String path) {
    return GoRoute(
      path: path,
      builder: (context, state) {
        // Return the builder function from the map
        final builder = _routeBuilders[route];
        if (builder != null) {
          return builder(context);
        } else {
          // Fallback in case no builder is found for the route
          return SplashPage();
        }
      },
    );
  }

  // Helper to get route path using the enum map
  String _getRoutePath(AppRoute route) {
    return _routePaths[route] ?? '/'; // Return default route if not found
  }

  // Builder for the initial route
  Widget _initialRouteBuilder(BuildContext context, GoRouterState state) {
    return FutureBuilder<bool>(
      future: _isFirstRun(),
      builder: (context, snapshot) {
        bool isFirstRun = snapshot.data ?? true;
        bool isSignedIn =
            context.read<AuthStatusBloc>().state.isSignedIn ?? false;

        if (isFirstRun) {
          return SplashPage();
        }

        if (!isFirstRun && isSignedIn) {
          return const HomePage();
        } else if (!isFirstRun && !isSignedIn) {
          return const LoginScreen();
        } else {
          return SplashPage(); // Same as placeholder
        }
      },
    );
  }

  // Builder for the post detail page
  Widget _postDetailPageBuilder(BuildContext context, GoRouterState state) {
    final categoryId = state.pathParameters['category_id']!;
    final postId = state.pathParameters['post_id']!;
    return PostDetailPage(
      categoryId: int.parse(categoryId),
      postId: int.parse(postId),
    );
  }

  void redirectToLoginPage() {
    router.go(_getRoutePath(AppRoute.login));
  }

  void redirectToHomePage() {
    router.go(_getRoutePath(AppRoute.home));
  }

  Future<bool> _isFirstRun() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    bool isFirstRun =
        keys.contains('isFirstRun') ? prefs.getBool('isFirstRun')! : true;
    String lastVersion = keys.contains('lastVersion')
        ? prefs.getString('lastVersion')!
        : '0.1.0';
    bool isUpdateProcessed = keys.contains('isUpdateProcessed')
        ? prefs.getBool('isUpdateProcessed')!
        : false;

    String currentVersion = '0.1.1';

    if (isFirstRun || (lastVersion != currentVersion && !isUpdateProcessed)) {
      await prefs.setBool('isFirstRun', false);
      await prefs.setString('lastVersion', currentVersion);
      await prefs.setBool('isUpdateProcessed', true);
      return true;
    } else {
      return false;
    }
  }
}
