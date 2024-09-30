import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/chat/provider/recent_room_provider.dart';
import 'package:hello_world_mvp/chat/service/recent_room_service.dart';
import 'package:hello_world_mvp/injection.dart';
import 'package:hello_world_mvp/toast/common_toast.dart';
import 'package:hello_world_mvp/toast/toast_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'auth/service/auth_service.dart';
// import 'auth/service/token/token_authenticator.dart';
import 'chat/provider/room_provider.dart';
import 'locale/locale_provider.dart';
import 'route/route_service.dart';

// void setupDio(Dio dio, TokenAuthenticator tokenAuthenticator) {
//   dio.interceptors.add(
//     InterceptorsWrapper(
//       onRequest:
//           (RequestOptions options, RequestInterceptorHandler handler) async {
//         final token = await tokenAuthenticator.fetchAccessToken();
//         if (token != null) {
//           options.headers['Authorization'] = 'Bearer $token';
//         }
//         handler.next(options);
//       },
//       onResponse:
//           (Response response, ResponseInterceptorHandler handler) async {
//         handler.next(response);
//       },
//       onError: (DioException e, ErrorInterceptorHandler handler) async {
//         if (e.response?.statusCode == 401) {
//           try {
//             final newOptions = await tokenAuthenticator.authenticate(
//               e.requestOptions,
//               e.response!,
//             );
//             final newResponse = await dio.request(
//               newOptions.path,
//               options: Options(
//                 method: newOptions.method,
//                 headers: newOptions.headers,
//               ),
//             );
//             handler.resolve(newResponse);
//           } catch (error) {
//             handler.reject(DioException(
//               requestOptions: e.requestOptions,
//               response: e.response,
//               error: error,
//             ));
//           }
//         } else {
//           handler.reject(e);
//         }
//       },
//     ),
//   );
// }

// Future<bool> _checkUserLoggedIn(AuthService authService) async {
//   final accessToken = await authService.fetchAccessToken();
//   return accessToken != null;
// }

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await EasyLocalization.ensureInitialized();

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('isFirstLaunch', 'true');
    prefs.setString('lastVersion', '0.1.0');

    configureDependencies();

    // final Dio dio = Dio();
    // final AuthService authService = AuthService(
    //   dio,
    // );

    // isUserLoggedIn() async => (await authService.fetchAccessToken()) != null;

    /*
  final TokenAuthenticator tokenAuthenticator = TokenAuthenticator(
    dio,
    'https://example.com/', // Base URL
    'token/refresh', // Token refresh URL
    routeService,
  );

  setupDio(dio, tokenAuthenticator);
  */

    final RecentRoomProvider recentRoomProvider = RecentRoomProvider();
    RecentRoomService recentRoomService = RecentRoomService(
      baseUrl: 'http://15.165.84.103:8082/chat/recent-room',
      userId: '1',
      recentRoomProvider: recentRoomProvider,
    );
    final routeService = RouteService(
      recentRoomService,
      isUserLoggedIn: Future.value(
          true), // Replace true with your actual login status check
    );

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
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => LocaleProvider()),
            ChangeNotifierProvider(create: (_) => RoomProvider()),
            ChangeNotifierProvider(
              create: (_) => RecentRoomProvider(),
            ),
          ],
          child: BlocProvider(
            create: (context) => getIt<ToastBloc>(),
            child: MainApp(
              // authService: authService,
              routeService: routeService,
            ),
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
    log("[MainApp] Detected locale: ${context.locale}");

    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) {
        final locale = localeProvider.locale ?? context.locale;
        // log("[MainApp] Applying locale: $locale");

        // log("[MainApp] EasyLocalization locale: ${EasyLocalization.of(context)?.locale}");

        return MultiBlocListener(
          listeners: [
            BlocListener<ToastBloc, ToastState>(
              listenWhen: (prev, cur) {
                return prev.message != cur.message;
              },
              listener: (context, state) {
                commonToastKey.currentState?.updateMessage(state.message);
              },
            ),
          ],
          child: MaterialApp.router(
            routerConfig: widget.routeService.router,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: localeProvider.locale ?? context.locale,
            builder: (context, child) {
              //CommonToast 하단 노란 두 줄 방지용
              return Stack(
                children: [child ?? const SizedBox(), commonToast],
              );
            },
          ),
        );
      },
    );
  }
}
