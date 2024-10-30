import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world_mvp/init/presentation/widgets/language_selection_widget.dart';
import 'package:hello_world_mvp/init/presentation/widgets/splash_text_label.dart';

import '../../locale/application/locale_bloc.dart';
import '../../route/application/route_bloc.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final languages = [
    {
      'locale': Locale('en', 'US'),
      'label': 'English',
      'flag': 'icons/flags/png100px/us.png'
    },
    {
      'locale': Locale('ja', 'JP'),
      'label': '日本語',
      'flag': 'icons/flags/png100px/jp.png'
    },
    {
      'locale': Locale('ko', 'KR'),
      'label': '한국어',
      'flag': 'icons/flags/png100px/kr.png'
    },
    {
      'locale': Locale('vi', 'VN'),
      'label': 'Tiếng Việt',
      'flag': 'icons/flags/png100px/vn.png'
    },
    {
      'locale': Locale('zh', 'CN'),
      'label': '中文',
      'flag': 'icons/flags/png100px/cn.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    Map<String, Object> selectedLanguage = languages[0];
    int selectedIndex = 0;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              // 배경 도형
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xffECF6FE),
                  // gradient: LinearGradient(
                  //   colors: [
                  //     Color(0xFFD1E6FF),
                  //     Color(0xFFDDEDFF),
                  //     Color(0xFFFFFFFF),
                  //   ],
                  //   begin: Alignment.topCenter,
                  //   end: Alignment.bottomCenter,
                  // ),
                ),
              ),
              // 큰 원
              Positioned(
                bottom: -MediaQuery.of(context).size.height / 5,
                left: MediaQuery.of(context).size.width / 2 - 400,
                child: ClipOval(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      width: 800,
                      height: 800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 5,
                left: MediaQuery.of(context).size.width / 2 - 100,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 5,
                      child: Image.asset(
                        'assets/images/home/Nice to meet you.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // SplashTextLabel(text: tr("splash_page.language_select")),
                    SplashTextLabel(text: "Select language"),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 2,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.height / 3,
                    child: ListView.builder(
                      itemCount: languages.length,
                      itemBuilder: (context, index) {
                        final language = languages[index];
                        final isSelected =
                            context.watch<LocaleBloc>().state.selectedIndex ==
                                index;

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: LanguageSelectionWidget(
                            flagPath: language['flag'] as String,
                            language: language['label'] as String,
                            isSelected: isSelected,
                            onTap: () {
                              selectedLanguage = language;
                              selectedIndex = index;
                              _handleLanguageSelection(
                                  context, language, index);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 1.16,
                left: MediaQuery.of(context).size.width / 1.5,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: IconButton(
                      onPressed: () {
                        context.read<RouteBloc>().add(
                              RouteChanged(
                                newIndex: 2,
                                newRoute: '/home',
                              ),
                            );
                        context.push('/home');
                      },
                      icon: Icon(
                        Icons.arrow_circle_right,
                        size: 60,
                        color: Color(0xffB7D3F6),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleLanguageSelection(
      BuildContext context, Map<String, dynamic> language, int index) {
    context.setLocale(language['locale'] as Locale);
    context.read<LocaleBloc>().add(
          SetLocale(
            locale: language['locale'] as Locale,
            index: index,
          ),
        );
  }
}
