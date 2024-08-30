import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'locale/locale_provider.dart';
import 'route/route_service.dart'; // Import the go_router package

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> _getImages() {
    return [
      'assets/images/home_chat.png',
      'assets/images/home_callbot.png',
      'assets/images/home_resume.png',
      'assets/images/home_job.png',
    ];
  }

  List<String> _getRoutes() {
    return [
      '/chat/:roomId', // Updated to include roomId
      '/callbot',
      '/resume',
      '/job',
    ];
  }

  String _getTextForIndex(int index, BuildContext context) {
    switch (index) {
      case 0:
        return 'chat_consultation'.tr();
      case 1:
        return 'call_bot'.tr();
      case 2:
        return 'resume_writing'.tr();
      case 3:
        return 'job_information'.tr();
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) {
        final currentLocale = localeProvider.locale ?? context.locale;
        log("[HomeScreen] Current locale: $currentLocale");
        log("[HomeScreen] locale: ${context.locale}");
        log("[HomeScreen] EasyLocalization locale: ${EasyLocalization.of(context)?.locale}");

        log("[HomeScreen] Translated text: ${'app_name'.tr()}");
        log("[HomeScreen] Translated text: ${'chat_consultation'.tr()}");

        final paddingVal = MediaQuery.of(context).size.height * 0.1;

        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.all(paddingVal),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("app_name",
                              style: TextStyle(
                                  fontSize: 28 * paddingVal / 100,
                                  fontWeight: FontWeight.bold))
                          .tr(),
                      Text("Hello World",
                          style: TextStyle(
                              fontSize: 28 * paddingVal / 100,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(bottom: 16 * paddingVal / 100),
                  child: Image.asset('assets/images/hello_world_logo.png',
                      fit: BoxFit.cover),
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0 * paddingVal / 50,
                      mainAxisSpacing: 8.0 * paddingVal / 50,
                      childAspectRatio: 1.5,
                    ),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      String assetName = _getImages()[index];
                      String route = _getRoutes()[index];

                      return GestureDetector(
                        onTap: () {
                          if (index == 1) {
                            selectedBottomNavIndex = 1;
                          }

                          context
                              .push(route); // Navigate to the route when tapped
                          log("[HomeScreen] Navigating to $route");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFB2B2F0)
                                .withOpacity(0.04), // B2B2F0 색상으로 배경 설정
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFB2B2F0)
                                    .withOpacity(0.08), // 그림자 색상
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: const Offset(0, 3), // 그림자 오프셋
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 16 * paddingVal / 100,
                                    left: 16 * paddingVal / 70,
                                    right: 16 * paddingVal / 70),
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    _getTextForIndex(index, context),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.0 * paddingVal / 100,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      EdgeInsets.all(16 * paddingVal / 120),
                                  child: Container(
                                    alignment: Alignment.bottomRight,
                                    child: Image.asset(
                                      assetName,
                                      width: 50 * paddingVal / 70,
                                      height: 50 * paddingVal / 70,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
