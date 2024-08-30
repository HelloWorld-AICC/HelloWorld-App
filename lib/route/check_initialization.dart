import 'dart:developer';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckInitialization {
  static Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstLaunch = prefs.getString('isFirstLaunch');
    final currentVersion = await _getCurrentAppVersion();
    final lastVersion = prefs.getString('lastVersion');
    // log("[CheckInitialization-isFirstLaunch()] lastVersion: $lastVersion, currentVersion: $currentVersion, isFirstLaunch: $isFirstLaunch");

    if (isFirstLaunch == 'true') {
      return true;
    }
    return lastVersion != currentVersion;
  }

  static Future<bool> performInitialization() async {
    try {
      final firstLaunch = await isFirstLaunch();

      log("[CheckInitialization-performInitialization()] isFirstLaunch: $firstLaunch");

      if (firstLaunch) {
        final prefs = await SharedPreferences.getInstance();
        final currentVersion = await _getCurrentAppVersion();
        await prefs.setString('lastVersion', currentVersion);
        await prefs.setString('isFirstLaunch', 'false');
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<String> _getCurrentAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    // log("CheckInitialization] packageInfo: $packageInfo");
    return packageInfo.version;
  }
}
