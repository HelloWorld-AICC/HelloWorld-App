import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckInitialization {
  static Future<bool> performInitialization() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final currentVersion = await _getCurrentAppVersion();
      final lastVersion = prefs.getString('lastVersion');

      final isFirstLaunch = lastVersion != currentVersion;

      if (isFirstLaunch) {
        await prefs.setString('lastVersion', currentVersion);
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<String> _getCurrentAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}
