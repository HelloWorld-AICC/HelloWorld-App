import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world_mvp/home/application/home_bloc.dart';
import 'package:hello_world_mvp/injection.dart';
import 'package:hello_world_mvp/locale/application/locale_bloc.dart';

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

  Future<List<String>> _getRoutes() async {
    return [
      '/chat',
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
    return BlocProvider(
      create: (context) => getIt<HomeBloc>()..add(GetToken()),
      child: Builder(builder: (context) {
        return BlocListener<HomeBloc, HomeState>(
          listenWhen: (prev, cur) {
            return prev.needSignIn != cur.needSignIn;
          },
          listener: (context, state) {
            if ((state.needSignIn ?? false) == true) {
              context.push("/login");
            }
          },
          child: BlocBuilder<LocaleBloc, LocaleState>(
            builder: (context, state) {
              final paddingVal = MediaQuery.of(context).size.height * 0.1;

              return Scaffold(
                body: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFD1E6FF),
                        Color(0xFFDDEDFF),
                        Color(0xFFFFFFFF),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(paddingVal / 1.6),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${tr("app_name")},",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: const Color(0xFF10498E),
                                ),
                              ),
                              Text(
                                "HelloWorld",
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF002E4F),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(bottom: 8),
                              child: SizedBox(
                                width: 250.0,
                                height: 300.0,
                                child: Image.asset(
                                  'assets/images/home/Nice to meet you.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            // Positioned(
                            //   bottom: 100,
                            //   child: Container(
                            //     alignment: Alignment.centerRight,
                            //     margin: EdgeInsets.only(bottom: 8),
                            //     child: SizedBox(
                            //       width: 250.0,
                            //       height: 300.0,
                            //       child: Image.asset(
                            //         'assets/images/home/Sphere 1.jpg',
                            //         fit: BoxFit.contain,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        Expanded(
                          child: RouteGrid(
                            getRoutes: _getRoutes,
                            getImages: _getImages,
                            getTextForIndex: _getTextForIndex,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}

class RouteGrid extends StatelessWidget {
  final Future<List<String>> Function() getRoutes;
  final List<String> Function() getImages;
  final String Function(int index, BuildContext context) getTextForIndex;

  RouteGrid({
    Key? key,
    required this.getRoutes,
    required this.getImages,
    required this.getTextForIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: getRoutes(), // Fetch the routes asynchronously
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final routes = snapshot.data!;
          final images = getImages();

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 1,
            ),
            itemCount: routes.length,
            itemBuilder: (context, index) {
              return RouteItem(
                index: index,
                route: routes[index],
                assetName: images[index],
                text: getTextForIndex(index, context),
              );
            },
          );
        } else {
          return const Center(child: Text('No routes available.'));
        }
      },
    );
  }
}

class RouteItem extends StatelessWidget {
  final int index;
  final String route;
  final String assetName;
  final String text;

  RouteItem({
    Key? key,
    required this.index,
    required this.route,
    required this.assetName,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(route); // Navigate to the route when tapped
        log("[HomeScreen] Navigating to $route");
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            color: const Color(0xFF6D9CD5).withOpacity(0.3),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFB2B2F0).withOpacity(0.08),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(3.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.topRight,
                child: Container(
                  width: 60,
                  height: 60,
                  child: Align(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Image.asset(
                        assetName,
                        width: 100.0,
                        height: 100.0,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Color(0xFF6D9CD5),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 2.0),
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Color(0xFF6D9CD5),
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
