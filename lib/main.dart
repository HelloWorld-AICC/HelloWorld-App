import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world_mvp/auth/application/status/auth_status_bloc.dart';
import 'package:hello_world_mvp/center/application/center_bloc.dart';
import 'package:hello_world_mvp/init/application/app_init_bloc.dart';
import 'package:hello_world_mvp/injection.dart';
import 'package:hello_world_mvp/locale/application/locale_bloc.dart';
import 'package:hello_world_mvp/mypage/edit_profile/presentation/edit_profile_screen.dart';
import 'package:hello_world_mvp/mypage/menu/presentation/mypage_menu_screen.dart';
import 'package:hello_world_mvp/new_chat/presentation/new_chat_page.dart';
import 'package:hello_world_mvp/route/application/route_bloc.dart';
import 'package:hello_world_mvp/route/domain/route_service.dart';
import 'package:hello_world_mvp/toast/common_toast.dart';
import 'package:hello_world_mvp/toast/toast_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/application/login_bloc.dart';
import 'auth/presentation/login_screen.dart';
import 'home/presentation/home_page.dart';
import 'init/presentation/splash_page.dart';
import 'new_chat/application/session/chat_session_bloc.dart';
import 'new_chat/domain/service/stream/streamed_chat_service.dart';
import 'new_chat/domain/service/stream/streamed_chat_parse_service.dart';
import 'new_chat/domain/service/chat_fetch_service.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await EasyLocalization.ensureInitialized();

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('isFirstLaunch', 'true');
    prefs.setString('lastVersion', '0.1.0');

    configureDependencies();

    runApp(
      EasyLocalization(
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ko', 'KR'),
          Locale('ja', 'JP'),
          Locale('zh', 'CN'),
          Locale('vi', 'VN'),
        ],
        path: 'assets/translations',
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => getIt<ToastBloc>(),
            ),
            BlocProvider(
              create: (context) => getIt<LocaleBloc>(),
            ),
            BlocProvider(
              create: (context) => getIt<AppInitBloc>(),
            ),
            BlocProvider(
              create: (context) => getIt<RouteBloc>(),
            ),
            BlocProvider(
              create: (context) => getIt<ChatSessionBloc>(),
            ),
            BlocProvider(
              create: (context) => getIt<AuthStatusBloc>(),
            ),
            BlocProvider(
              create: (context) => getIt<LoginBloc>(),
            ),
            BlocProvider(
              create: (context) => getIt<CenterBloc>(),
            )
          ],
          child: MainApp(),
        ),
      ),
    );
  }, (error, stackTrace) async {
    showToast(error.toString());
    // await FlutterCrashlytics()
    //     .reportCrash(error, stackTrace, forceCrash: false);
  });
}

class MainApp extends StatefulWidget {
  const MainApp({
    super.key,
  });

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  GlobalKey<CommonToastState> commonToastKey = GlobalKey<CommonToastState>();
  late CommonToast commonToast = CommonToast(key: commonToastKey);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      commonToast = CommonToast(
        key: commonToastKey,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleBloc, LocaleState>(
      buildWhen: (previous, current) {
        return previous.locale != current.locale;
      },
      builder: (context, state) {
        final locale = state.locale ?? context.locale;
        return MultiBlocListener(
          listeners: [
            BlocListener<ToastBloc, ToastState>(
              listenWhen: (prev, cur) => prev.message != cur.message,
              listener: (context, state) {
                commonToastKey.currentState?.updateMessage(state.message);
              },
            ),
            BlocListener<AuthStatusBloc, AuthStatusState>(
              listener: (context, state) {
                if (state.isSignedIn != null) {
                  print(
                      'main :: build :: AuthStatusBloc state updated: isSignedIn=${state.isSignedIn}, isFirstRun=${state.isFirstRun}');
                }
              },
            ),
          ],
          child: MaterialApp.router(
            routerConfig: getIt<RouteService>().router,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: locale,
            builder: (context, child) {
              return ToastWrapper(
                commonToast: commonToast,
                widget: child,
              );
            },
          ),
        );
      },
    );
  }
}

class ToastWrapper extends StatelessWidget {
  const ToastWrapper({super.key, required this.commonToast, this.widget});

  final CommonToast commonToast;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          SafeArea(child: widget ?? const SizedBox()),
          Positioned(top: 0, bottom: 0, left: 0, right: 0, child: commonToast),
        ],
      ),
    );
  }
}
