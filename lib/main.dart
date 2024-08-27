import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'route/route_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

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
        child: const MainApp()),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

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

    setState(() {});
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
