import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world_mvp/community/board/presentation/community_board.dart';
import 'package:hello_world_mvp/community/common/domain/post.dart';
import 'package:hello_world_mvp/community/create_post/presentation/create_post_page.dart';
import 'package:hello_world_mvp/community/post_detail/presentation/post_detail_page.dart';
import 'package:hello_world_mvp/mypage/account/presentation/account_screen.dart';
import 'package:hello_world_mvp/mypage/privacy_policy/presentation/privacy_policy_screen.dart';
import 'package:hello_world_mvp/mypage/term/presentation/term_screen.dart';
import 'package:hello_world_mvp/mypage/withdraw/presentation/withdraw_screen.dart';
import 'package:injectable/injectable.dart';

import '../../auth/presentation/login_screen.dart';
import '../../home/presentation/home_page.dart';
import '../../init/application/app_init_bloc.dart';
import '../../init/presentation/splash_page.dart';
import '../../init/presentation/terms_of_service_page.dart';
import '../../mypage/edit_profile/presentation/edit_profile_screen.dart';
import '../../mypage/menu/presentation/mypage_menu_screen.dart';
import '../../new_chat/presentation/new_chat_page.dart';
import '../../new_chat/presentation/widgets/new_chat_content.dart';

@LazySingleton()
@Injectable()
class RouteService {
  final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          context.read<AppInitBloc>().add(CheckAppFirstRun());
          final isFirstRun = context.read<AppInitBloc>().state.isFirstRun;
          printInColor("isFirstRun: $isFirstRun", color: blue);
          return isFirstRun ? SplashPage() : const LoginScreen();
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
        path: '/account',
        builder: (context, state) => const AccountScreen(),
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
        path: '/withdraw',
        builder: (context, state) => const WithdrawScreen(),
      ),
      GoRoute(
        path: '/community/board',
        builder: (context, state) => const CommunityBoard(),
      ),
      GoRoute(
        path: '/community/:category_id/posts/:post_id',
        name: 'post-detail',
        builder: (context, state) {
          final int postId = int.parse(state.pathParameters['post_id'] ?? "");
          final int categoryId =
              int.parse(state.pathParameters['category_id'] ?? "");

          return PostDetailPage(postId: postId, categoryId: categoryId);
        },
      ),
      GoRoute(
        path: '/community/create-post',
        builder: (context, state) => const CreatePostPage(),
      ),
      GoRoute(
        path: '/term',
        builder: (context, state) => const TermScreen(),
      ),
      GoRoute(
        path: '/privacy-policy',
        builder: (context, state) => const PrivacyPolicyScreen(),
      )
    ],
  );
}
