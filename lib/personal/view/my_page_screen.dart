import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world_mvp/personal/service/preference_service.dart';
import 'package:provider/provider.dart';

import '../../chat/provider/recent_room_provider.dart';
import '../../chat/service/recent_room_service.dart';
import '../../locale/locale_provider.dart';
import '../../route/route_service.dart';
import '../model/user.dart';
import '../model/user_preferences.dart';
import 'components/profile_widget.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  _MyPageScreenState createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  User user = UserPreferences().myUser;

  @override
  void initState() {
    super.initState();
    PreferenceService.updateUserPreferences();
    user = UserPreferences().myUser;
    log("[MyPageScreen] UserPreferences updated");
    log("[MyPageScreen] UserPreferences: ${UserPreferences().myUser.id}, ${UserPreferences().myUser.name}, ${UserPreferences().myUser.imagePath}");
  }

  @override
  Widget build(BuildContext context) {
    log("[MyPageScreen-build] UserPreferences: ${UserPreferences().myUser.id}, ${UserPreferences().myUser.name}, ${UserPreferences().myUser.imagePath}");

    return Consumer<RecentRoomProvider>(
      builder: (context, recentRoomProvider, child) {
        return Scaffold(
          appBar: buildAppBar(context),
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  ProfileWidget(
                    imagePath: user.imagePath,
                    onClicked: () {
                      context.push('/edit-profile');
                    },
                  ),
                  const SizedBox(height: 24),
                  buildName(user),
                  const SizedBox(height: 24),
                  buildLocaleChangeButton(context),
                ],
              ),
            ),
          ),
          // Your Scaffold properties
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: tr('home'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.chat),
                label: tr('chat'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person),
                label: tr('profile'),
              ),
            ],
            currentIndex: selectedBottomNavIndex,
            onTap: (index) async {
              if (index == 1) {
                // Fetch recent chat room when the chat screen tab is tapped
                try {
                  recentRoomProvider.fetchRecentChatRoom(
                    Provider.of<RecentRoomService>(context, listen: false),
                  );

                  final recentRoom = recentRoomProvider.recentChatRoom;

                  if (recentRoom?.roomId == 'new_chat') {
                    context.go('/chat/new_chat');
                  } else if (recentRoom != null) {
                    context.go('/chat/${recentRoom.roomId}');
                  } else {
                    // Handle the case when there is no recent chat room
                    context.go('/chat');
                  }
                } catch (e) {
                  // Handle the error appropriately
                  print('Failed to fetch recent chat room: $e');
                }
              } else {
                context.go(bottomNavItems[index]);
              }
            },
          ),
        );
      },
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey[200],
      elevation: 0,
      centerTitle: true,
      title: Text(
        tr('MyPage'),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.id,
            style: const TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildLocaleChangeButton(BuildContext context) {
    return IntrinsicWidth(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue, // 버튼의 배경 색상
          shape: const StadiumBorder(), // 버튼의 모양
          padding: const EdgeInsets.symmetric(
              horizontal: 32, vertical: 12), // 버튼의 패딩
        ),
        onPressed: () {
          showLocaleSelectionDialog(context);
        },
        child: Text(tr('change_locale_button')),
      ),
    );
  }

  void showLocaleSelectionDialog(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Locale'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var locale in localeProvider.supportedLocales)
                ListTile(
                  title: Text(locale.toLanguageTag()),
                  onTap: () {
                    Provider.of<LocaleProvider>(context, listen: false)
                        .setLocale(locale);
                    EasyLocalization.of(context)?.setLocale(locale);
                    Navigator.of(context).pop();
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
