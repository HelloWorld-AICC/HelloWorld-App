import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/service/auth_service.dart';
import 'locale/locale_provider.dart';
import 'route/route_service.dart';
import 'token/token_authenticator.dart';

void setupDio(Dio dio, TokenAuthenticator tokenAuthenticator) {
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async {
        final token = await tokenAuthenticator.fetchAccessToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onResponse:
          (Response response, ResponseInterceptorHandler handler) async {
        handler.next(response);
      },
      onError: (DioException e, ErrorInterceptorHandler handler) async {
        if (e.response?.statusCode == 401) {
          try {
            final newOptions = await tokenAuthenticator.authenticate(
              e.requestOptions,
              e.response!,
            );
            final newResponse = await dio.request(
              newOptions.path,
              options: Options(
                method: newOptions.method,
                headers: newOptions.headers,
              ),
            );
            handler.resolve(newResponse);
          } catch (error) {
            handler.reject(DioException(
              requestOptions: e.requestOptions,
              response: e.response,
              error: error,
            ));
          }
        } else {
          handler.reject(e);
        }
      },
    ),
  );
}

Future<bool> _checkUserLoggedIn(AuthService authService) async {
  final accessToken = await authService.fetchAccessToken();
  return accessToken != null;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  prefs.setString('isFirstLaunch', 'true');
  prefs.setString('lastVersion', '0.1.0');

  final Dio dio = Dio();
  final AuthService authService = AuthService(
    dio,
  );

  // isUserLoggedIn() async => (await authService.fetchAccessToken()) != null;

  final RouteService routeService = RouteService(
    isUserLoggedIn: _checkUserLoggedIn(authService),
  );

  final TokenAuthenticator tokenAuthenticator = TokenAuthenticator(
    dio,
    'https://example.com/', // Base URL
    'token/refresh', // Token refresh URL
    routeService,
  );

  setupDio(dio, tokenAuthenticator);

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
      fallbackLocale: const Locale('ko'),
      child: ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
        child: MainApp(
          authService: authService,
          routeService: RouteService(
            isUserLoggedIn: _checkUserLoggedIn(authService),
          ),
        ),
      ),
    ),
  );
}

class MainApp extends StatefulWidget {
  final AuthService authService;
  final RouteService routeService;

  const MainApp({
    super.key,
    required this.authService,
    required this.routeService,
  });

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: widget.routeService.router,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
