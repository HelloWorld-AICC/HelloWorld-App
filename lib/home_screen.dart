import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'chat/provider/recent_room_provider.dart';
import 'chat/service/recent_room_service.dart';
import 'locale/locale_provider.dart';
import 'route/route_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _recentRoomId = 'new_chat'; // Store the recent room ID

  late RecentRoomService _recentRoomService;

  @override
  void initState() {
    super.initState();
    final recentRoomProvider =
        Provider.of<RecentRoomProvider>(context, listen: false);
    _recentRoomService = RecentRoomService(
      baseUrl: 'http://15.165.84.103:8082/chat/recent-room',
      userId: '1',
      recentRoomProvider: recentRoomProvider,
    );
    _fetchRecentRoomId();
  }

  Future<void> _fetchRecentRoomId() async {
    try {
      await _recentRoomService.fetchRecentChatRoom();
      setState(() {
        _recentRoomId =
            context.read<RecentRoomProvider>().recentChatRoom?.roomId ??
                'new_chat';
      });
    } catch (e) {
      log('Error fetching recent room ID: $e');
      _recentRoomId = 'new_chat'; // Fallback in case of error
    }
  }

  List<String> _getImages() {
    return [
      'assets/images/home_chat.png',
      'assets/images/home_callbot.png',
      'assets/images/home_resume.png',
      'assets/images/home_job.png',
    ];
  }

  Future<List<String>> _getRoutes() async {
    if (_recentRoomId == 'new_chat') {
      await _fetchRecentRoomId();
    }

    return [
      '/chat/$_recentRoomId', // Updated to include roomId
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
        final paddingVal = MediaQuery.of(context).size.height * 0.1;

        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.all(paddingVal / 1.6),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    context.push("/login");
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${tr("app_name")},",
                          style: TextStyle(
                            fontSize: 32 * paddingVal / 100,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Hello World",
                          style: TextStyle(
                            fontSize: 32 * paddingVal / 100,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(bottom: 8 * paddingVal / 100),
                  child: SizedBox(
                    width: 250.0 * paddingVal / 100, // Width of the image
                    height: 300.0 * paddingVal / 100, // Height of the image
                    child: Image.asset(
                      'assets/images/hello_world_logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Expanded(
                  child: FutureBuilder<List<String>>(
                    future: _getRoutes(), // Fetch the routes asynchronously
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        final routes = snapshot.data!;

                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0 * paddingVal / 50,
                            mainAxisSpacing: 8.0 * paddingVal / 50,
                            childAspectRatio: 1, // Aspect ratio for grid items
                          ),
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            String assetName = _getImages()[index];
                            String route = routes[index];
                            String text = _getTextForIndex(index, context);

                            return GestureDetector(
                              onTap: () {
                                if (index == 1) {
                                  selectedBottomNavIndex = 1;
                                }
                                context.push(
                                    route); // Navigate to the route when tapped
                                log("[HomeScreen] Navigating to $route");
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 224, 224, 224)
                                          .withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(15.0),
                                  border: Border.all(
                                    color: const Color(0xFFB2B2F0)
                                        .withOpacity(0.3),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFFB2B2F0)
                                          .withOpacity(0.08),
                                      spreadRadius: 2,
                                      blurRadius: 2,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(
                                            8.0 * paddingVal / 100),
                                        child: Text(
                                          text,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 24.0 * paddingVal / 100,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment
                                              .centerRight, // Align image to bottom-right
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                                8.0 * paddingVal / 100),
                                            child: Image.asset(
                                              assetName,
                                              width: 100.0 *
                                                  paddingVal /
                                                  100, // Set to desired width
                                              height: 100.0 *
                                                  paddingVal /
                                                  100, // Set to desired height
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(
                            child: Text('No routes available.'));
                      }
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
