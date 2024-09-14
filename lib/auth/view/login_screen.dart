// import 'dart:developer';

// import 'package:dio/dio.dart';
// import 'package:easy_localization/easy_localization.dart'; // Import easy_localization
// import 'package:flutter/material.dart';
// import 'package:uni_links2/uni_links.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../service/auth_service.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hello_world_mvp/auth/viewmodel/login_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginVM(),
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 70),
                const _Title(),
                const SizedBox(height: 20),
                Image.asset(
                  "assets/images/auth/login_main.png",
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
                const SizedBox(height: 4),
                const _LoginButtonArea()
              ],
            )),
      ),
    );
  }
}

class _LoginButtonArea extends StatelessWidget {
  const _LoginButtonArea();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(16),
          child: const Center(child: _LoginWithGoogle())),
    );
  }
}

class _LoginWithGoogle extends StatelessWidget {
  const _LoginWithGoogle();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<LoginVM>().authorize();
      },
      child: Container(
          height: 35,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 1,
                color: const Color(0xFFEBEBEB),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/auth/google_logo.png"),
              const SizedBox(width: 8),
              const Text("Google로 로그인",
                  style: TextStyle(
                    color: Color(0xFF0F0F0F),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 20 / 12,
                    letterSpacing: 0.1,
                  ))
            ],
          )),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Text("외국인 지원센터 AICC\nHello World",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            height: 1.0,
          )),
    );
  }
}

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
