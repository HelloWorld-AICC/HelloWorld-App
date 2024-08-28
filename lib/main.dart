import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/token_authenticator.dart';
import 'route/route_service.dart';

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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final Dio dio = Dio();
  final RouteService routeService = RouteService(
    isFirstLaunch: false, // Placeholder, will be updated later
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
        Locale('vi', 'VN')
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: MainApp(
        tokenAuthenticator: tokenAuthenticator,
        routeService: routeService,
      ),
    ),
  );
}

class MainApp extends StatefulWidget {
  final TokenAuthenticator tokenAuthenticator;
  final RouteService routeService;

  const MainApp({
    super.key,
    required this.tokenAuthenticator,
    required this.routeService,
  });

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool? isFirstLaunch;
  RouteService? _routeService;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // 앱 버전 관리로 첫 실행 확인
    String currentVersion = packageInfo.version;
    String? lastVersion = prefs.getString('lastVersion');
    isFirstLaunch = lastVersion != currentVersion;

    if (isFirstLaunch!) {
      await prefs.setString('lastVersion', currentVersion);
    }

    _routeService = RouteService(
      isFirstLaunch: isFirstLaunch!,
    );

    setState(() {
      _routeService = RouteService(
        isFirstLaunch: isFirstLaunch!,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isFirstLaunch == null) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return MaterialApp.router(
      routerConfig: _routeService!.router,
    );
  }
}
