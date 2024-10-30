// import 'dart:developer';
//
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:hello_world_mvp/locale/application/locale_bloc.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'first_launch_view_model.dart'; // Import the ViewModel class
// import 'locale_provider.dart'; // Import the LocaleProvider class
//
// class FirstLaunchScreen extends StatefulWidget {
//   const FirstLaunchScreen({super.key});
//
//   @override
//   State<FirstLaunchScreen> createState() => _FirstLaunchScreenState();
// }
//
// class _FirstLaunchScreenState extends State<FirstLaunchScreen> {
//   Locale? _selectedLocale;
//   late FirstLaunchViewModel _viewModel;
//
//   final List<Locale> supportedLocales = [
//     const Locale('en', 'US'),
//     const Locale('ko', 'KR'),
//     const Locale('ja', 'JP'),
//     const Locale('zh', 'CN'),
//     const Locale('vi', 'VN'),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _viewModel = FirstLaunchViewModel();
//     _loadLocaleFromServer();
//   }
//
//   // Define a mapping between server locale strings and app locale codes
//   static const Map<String, Locale> serverToAppLocale = {
//     'ENGLISH': Locale('en', 'US'),
//     'KOREAN': Locale('ko', 'KR'),
//     'JAPANESE': Locale('ja', 'JP'),
//     'CHINESE': Locale('zh', 'CN'),
//     'VIETNAMESE': Locale('vi', 'VN'),
//     // Add more mappings as needed
//   };
//
//   Future<void> _loadLocaleFromServer() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     var userId = prefs.getString('userId') ?? '1';
//     var localeString = await _viewModel.fetchLocaleFromServer(userId);
//     // log("[FirstLaunchScreen-loadLocaleFromServer()] Locale from server: $localeString");
//
//     if (localeString != null) {
//       Locale locale = serverToAppLocale[localeString.toUpperCase()] ??
//           const Locale('en', 'US'); // Default to 'en' if not found;
//       // log("[FirstLaunchScreen-loadLocalFromServer()] Setting locale from server: $locale");
//       setState(() {
//         _selectedLocale = locale;
//       });
//     }
//   }
//
//   String _localeDisplayName(Locale locale) {
//     switch (locale.languageCode) {
//       case 'en':
//         return 'lan_en';
//       case 'ko':
//         return 'lan_ko';
//       case 'ja':
//         return 'lan_ja';
//       case 'zh':
//         return 'lan_zh';
//       case 'vi':
//         return 'lan_vi';
//       default:
//         return 'lan_en';
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final paddingVal = MediaQuery.of(context).size.height * 0.1;
//
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           "select_language".tr(), // Apply translation
//           style: TextStyle(
//             fontSize: 20 * paddingVal / 100,
//             fontWeight: FontWeight.bold,
//             color: Colors.black, // Set text color
//           ),
//           textAlign: TextAlign.center,
//         ),
//         backgroundColor: Colors.grey[200], // Light grey background
//         elevation: 4, // Apply shadow
//         shadowColor: Colors.black.withOpacity(0.3), // Shadow color
//       ),
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Center(
//           child: Padding(
//             padding: EdgeInsets.all(24 * paddingVal / 100),
//             child: Wrap(
//               spacing: 8.0 * paddingVal / 100, // Horizontal space between tiles
//               runSpacing:
//                   8.0 * paddingVal / 100, // Vertical space between lines
//               children: supportedLocales.map((locale) {
//                 final isSelected = _selectedLocale == locale;
//                 return ChoiceChip(
//                   label: Text(
//                     _localeDisplayName(locale).tr(),
//                     style: TextStyle(
//                       color: isSelected ? Colors.white : Colors.black,
//                       fontSize: 16 * paddingVal / 80,
//                     ),
//                   ),
//                   selected: isSelected,
//                   backgroundColor: Colors.grey[200],
//                   selectedColor: Colors.blue,
//                   onSelected: (selected) {
//                     // 로케일을 바로 변경하지 않고, 단지 선택된 로케일을 변경
//                     setState(() {
//                       _selectedLocale = locale;
//                     });
//                   },
//                 );
//               }).toList(),
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: EdgeInsets.all(32.0 * paddingVal / 100),
//         child: ElevatedButton(
//           onPressed: _selectedLocale != null
//               ? () async {
//                   // Update locale using provider only when Confirm button is pressed
//                   // context.read<LocaleProvider>().setLocale(_selectedLocale!);
//                   // log("[FirstLaunchScreen-ConfirmButton] Selected locale: ${_selectedLocale!}");
//
//                   context
//                       .read<LocaleBloc>()
//                       .add(SetLocale(locale: _selectedLocale!));
//                   EasyLocalization.of(context)?.setLocale(_selectedLocale!);
//
//                   WidgetsBinding.instance.addPostFrameCallback((_) {
//                     if (context.mounted) {
//                       // Safe to use context
//                       Navigator.pushReplacementNamed(context, '/home');
//                     } else {
//                       // Handle the case where the context is no longer valid
//                       log("Context is no longer mounted.");
//                     }
//                   });
//
//                   // Uncomment and use this code if needed
//                   // Send selected locale to server
//                   // final SharedPreferences prefs = await SharedPreferences.getInstance();
//                   // var userId = prefs.getString('userId');
//                   // var response = await http.post(
//                   //   Uri.parse('http://localhost:8082/api/setLanguage'),
//                   //   headers: <String, String>{
//                   //     'Content-Type': 'application/json; charset=UTF-8',
//                   //     'user_id': userId ?? "user1",
//                   //   },
//                   //   body: jsonEncode(
//                   //       {'locale': _selectedLocale!.languageCode}),
//                   // );
//                 }
//               : null,
//           child: Text('confirm_button',
//                   style: TextStyle(
//                       fontSize: 16 * paddingVal / 80,
//                       fontWeight: FontWeight.bold))
//               .tr(),
//         ),
//       ),
//     );
//   }
// }
