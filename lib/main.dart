import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hello_world_mvp/chat/provider/recent_room_provider.dart';
import 'package:hello_world_mvp/chat/service/recent_room_service.dart';
import 'package:hello_world_mvp/injection.dart';
import 'package:hive/hive.dart';
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
    isUserLoggedIn:
        Future.value(true), // Replace true with your actual login status check
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
        child: MainApp(
          // authService: authService,
          routeService: routeService,
        ),
      ),
    ),
  );
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
  @override
  Widget build(BuildContext context) {
    log("[MainApp] Detected locale: ${context.locale}");

    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) {
        final locale = localeProvider.locale ?? context.locale;
        // log("[MainApp] Applying locale: $locale");

        // log("[MainApp] EasyLocalization locale: ${EasyLocalization.of(context)?.locale}");

        return MaterialApp.router(
          routerConfig: widget.routeService.router,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: localeProvider.locale ?? context.locale,
        );
      },
    );
  }
}
