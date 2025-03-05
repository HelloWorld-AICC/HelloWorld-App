import 'package:flutter/cupertino.dart';
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
import 'package:hello_world_mvp/resume/new_resume_screen.dart';
import 'package:hello_world_mvp/resume/prev/resume_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

final router = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => SplashPage(),
    redirect: (context, state) async {
      final prefs = await SharedPreferences.getInstance();
      bool isFirstRun = prefs.getBool('isFirstRun') ?? true;
      bool isSignedIn =
          context.read<AuthStatusBloc>().state.isSignedIn ?? false;

      if (!isFirstRun && isSignedIn) {
        return '/home';
      } else if (!isFirstRun && !isSignedIn) {
        return '/login';
      } else {
        return null;
      }
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
    path: '/consultation_center',
    builder: (context, state) => CenterScreen(),
  ),
  GoRoute(
    path: '/community',
    builder: (context, state) => CommunityBoard(),
  ),
  GoRoute(
    path: '/community/board',
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
  ),
  GoRoute(
    path: '/account',
    builder: (context, state) => AccountScreen(),
  ),
  GoRoute(
    path: '/term',
    builder: (context, state) => TermsOfServicePage(),
  ),
  GoRoute(
    path: '/privacy-policy',
    builder: (context, state) => PrivacyPolicyScreen(),
  ),
  GoRoute(
    path: '/resume',
    builder: (context, state) => ResumeScreen(),
  ),
  GoRoute(
    path: '/callbot',
    builder: (context, state) => const CallBotScreen(),
  ),
  GoRoute(
    path: '/withdraw',
    builder: (context, state) => const WithdrawScreen(),
  )
], observers: [
  // CustomNavigatorObserver(getIt<RouteBloc>()),
]);
