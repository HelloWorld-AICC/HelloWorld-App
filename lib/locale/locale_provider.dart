import 'dart:developer';

import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  Locale? _locale;

  final List<Locale> _supportedLocales = const [
    Locale('en', 'US'),
    Locale('ko', 'KR'),
    Locale('ja', 'JP'),
    Locale('zh', 'CN'),
    Locale('vi', 'VN'),
  ];

  Locale? get locale => _locale;
  List<Locale> get supportedLocales => _supportedLocales;

  void setLocale(Locale locale) {
    _locale = locale;
    log("[LocaleProvider] setLocale: $locale");
    notifyListeners();
  }
}
