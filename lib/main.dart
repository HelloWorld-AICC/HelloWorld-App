import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/injection.dart';
import 'package:hello_world_mvp/locale/application/locale_bloc.dart';
import 'package:hello_world_mvp/route/new_route_service.dart';
import 'package:hello_world_mvp/toast/common_toast.dart';
import 'package:hello_world_mvp/toast/toast_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'new_chat/application/app/navigation/tab_navigation_bloc.dart';
import 'new_chat/application/set_up.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await EasyLocalization.ensureInitialized();

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('isFirstLaunch', 'true');
    prefs.setString('lastVersion', '0.1.0');

    configureDependencies();
    final routeService = RouteService();

    setupServiceLocator();

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
            BlocProvider<TabNavigationBloc>(
              create: (context) => getIt<TabNavigationBloc>(),
            ),
          ],
          child: MainApp(
            routeService: routeService,
          ),
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
  // final AuthService authService;
  final RouteService routeService;

  const MainApp({
    super.key,
    // required this.authService,
    required this.routeService,
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
          ],
          child: MaterialApp.router(
            routerConfig: widget.routeService.router,
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
