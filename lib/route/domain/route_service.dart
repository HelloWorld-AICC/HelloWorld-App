import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../../auth/presentation/login_screen.dart';
import '../../home/presentation/home_page.dart';
import '../../init/presentation/splash_page.dart';
import '../../mypage/edit_profile/presentation/edit_profile_screen.dart';
import '../../mypage/menu/presentation/mypage_menu_screen.dart';
import '../../new_chat/presentation/new_chat_page.dart';

@LazySingleton()
@Injectable()
class RouteService {
  final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
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
    ],
  );
}
