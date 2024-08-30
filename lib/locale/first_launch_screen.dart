import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'first_launch_view_model.dart'; // Import the ViewModel class
import 'locale_provider.dart'; // Import the LocaleProvider class

class FirstLaunchScreen extends StatefulWidget {
  const FirstLaunchScreen({super.key});

  @override
  State<FirstLaunchScreen> createState() => _FirstLaunchScreenState();
}

class _FirstLaunchScreenState extends State<FirstLaunchScreen> {
  Locale? _selectedLocale;
  late FirstLaunchViewModel _viewModel;

  final List<Locale> supportedLocales = [
    const Locale('en', 'US'),
    const Locale('ko', 'KR'),
    const Locale('ja', 'JP'),
    const Locale('zh', 'CN'),
    const Locale('vi', 'VN'),
  ];

  @override
  void initState() {
    super.initState();
    _viewModel = FirstLaunchViewModel();
    _loadLocaleFromServer();
  }

  Future<void> _loadLocaleFromServer() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('userId') ?? '1';
    var localeString = await _viewModel.fetchLocaleFromServer(userId);

    if (localeString != null) {
      Locale locale = Locale(localeString);
      setState(() {
        _selectedLocale = locale;
      });
      // Set the locale using provider
      context.read<LocaleProvider>().setLocale(locale);
    }
  }

  String _localeDisplayName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'lan_en';
      case 'ko':
        return 'lan_ko';
      case 'ja':
        return 'lan_ja';
      case 'zh':
        return 'lan_zh';
      case 'vi':
        return 'lan_vi';
      default:
        return 'lan_en';
    }
  }

  @override
  Widget build(BuildContext context) {
    final paddingVal = MediaQuery.of(context).size.height * 0.1;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "select_language".tr(), // Apply translation
          style: TextStyle(
            fontSize: 20 * paddingVal / 100,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Set text color
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.grey[200], // Light grey background
        elevation: 4, // Apply shadow
        shadowColor: Colors.black.withOpacity(0.3), // Shadow color
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24 * paddingVal / 100),
          child: Wrap(
            spacing: 8.0 * paddingVal / 100, // Horizontal space between tiles
            runSpacing: 8.0 * paddingVal / 100, // Vertical space between lines
            children: supportedLocales.map((locale) {
              final isSelected = _selectedLocale == locale;
              return ChoiceChip(
                label: Text(
                  _localeDisplayName(locale).tr(),
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontSize: 16 * paddingVal / 100,
                  ),
                ),
                selected: isSelected,
                backgroundColor: Colors.grey[200],
                selectedColor: Colors.blue,
                onSelected: (selected) {
                  setState(() {
                    _selectedLocale = locale;
                  });
                  // Update locale using provider
                  context.read<LocaleProvider>().setLocale(locale);
                },
              );
            }).toList(),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(32.0 * paddingVal / 100),
        child: ElevatedButton(
          onPressed: _selectedLocale != null
              ? () {
                  // Update locale using provider
                  context.read<LocaleProvider>().setLocale(_selectedLocale!);
                  log("[FirstLaunchScreen-ConfirmButton] Selected locale: ${_selectedLocale!.languageCode}");

                  // Uncomment and use this code if needed
                  // Send selected locale to server
                  // final SharedPreferences prefs = await SharedPreferences.getInstance();
                  // var userId = prefs.getString('userId');
                  // var response = await http.post(
                  //   Uri.parse('http://localhost:8082/api/setLanguage'),
                  //   headers: <String, String>{
                  //     'Content-Type': 'application/json; charset=UTF-8',
                  //     'user_id': userId ?? "user1",
                  //   },
                  //   body: jsonEncode(
                  //       {'locale': _selectedLocale!.languageCode}),
                  // );

                  // Navigate to the next screen
                  context.go(
                      '/home'); // Change '/next_screen' to your desired route
                }
              : null,
          child: Text('confirm_button',
                  style: TextStyle(
                      fontSize: 16 * paddingVal / 100,
                      fontWeight: FontWeight.bold))
              .tr(),
        ),
      ),
    );
  }
}
