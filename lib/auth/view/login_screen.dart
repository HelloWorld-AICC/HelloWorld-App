// import 'dart:developer';

// import 'package:dio/dio.dart';
// import 'package:easy_localization/easy_localization.dart'; // Import easy_localization
// import 'package:flutter/material.dart';
// import 'package:uni_links2/uni_links.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../service/auth_service.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final AuthService _authService = AuthService(Dio());

//   @override
//   void initState() {
//     super.initState();
//     _initUniLinks();
//   }

//   Future<void> _initUniLinks() async {
//     try {
//       final initialLink = await getInitialLink();
//       _handleIncomingLink(initialLink);
//       linkStream.listen((String? link) {
//         _handleIncomingLink(link);
//       });
//     } catch (e) {
//       log('Error occurred: $e');
//     }
//   }

//   void _handleIncomingLink(String? link) {
//     if (link != null && link.contains('code=')) {
//       final code = Uri.parse(link).queryParameters['code'];
//       log('[LoginScreen] Received auth code: $code');
//       // Use the code to fetch the access token from your server
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final paddingVal = MediaQuery.of(context).size.height * 0.1;

//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: Padding(
//           padding: EdgeInsets.all(paddingVal),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: Column(
//                     children: [
//                       Container(
//                         margin: const EdgeInsets.only(bottom: 16),
//                         alignment: Alignment.topLeft,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text("app_name",
//                                     style: TextStyle(
//                                         fontSize: 24 * paddingVal / 100,
//                                         fontWeight: FontWeight.bold))
//                                 .tr(),
//                             Text("Hello World",
//                                 style: TextStyle(
//                                     fontSize: 24 * paddingVal / 100,
//                                     fontWeight: FontWeight.bold)),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         child: Image.asset('assets/images/hello_world_logo.png',
//                             fit: BoxFit.cover),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       try {
//                         var temp = await _authService.getGoogleAuthUrl();
//                         var googleAuthUrl = temp['googleAuthUrl'];
//                         log("[LoginScreen] Google Auth URL: $googleAuthUrl");
//                         final uri = Uri.parse(googleAuthUrl);

//                         if (googleAuthUrl != null && googleAuthUrl.isNotEmpty) {
//                           // Launch the URL using url_launcher
//                           if (await canLaunchUrl(uri)) {
//                             await launchUrl(uri);
//                           } else {
//                             log("Could not launch $googleAuthUrl");
//                           }
//                         }
//                       } catch (e) {
//                         log("Error occurred: $e");
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.blue,
//                       backgroundColor: Colors.white,
//                       shadowColor: Colors.grey[20],
//                       // elevation: 10.0,
//                       textStyle: const TextStyle(
//                           fontWeight: FontWeight.w700, fontSize: 20.0),
//                       padding: const EdgeInsets.all(12.0),
//                       side: const BorderSide(color: Colors.blue, width: 2.0),
//                     ),
//                     child: Text('login_button',
//                             style: TextStyle(
//                                 fontSize: 16 * paddingVal / 100,
//                                 fontWeight: FontWeight.bold))
//                         .tr(), // Use easy_localization here
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
