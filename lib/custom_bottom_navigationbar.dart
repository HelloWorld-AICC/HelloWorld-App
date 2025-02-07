import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world_mvp/design_system/hello_colors.dart';
import 'package:hello_world_mvp/route/domain/route_service.dart';
import 'package:hello_world_mvp/toast/common_toast.dart';

import 'locale/domain/localization_service.dart';
import 'route/application/route_bloc.dart';

final Map<String, ImageIcon> bottomNavItems = {
  'bottom_navigation.chat':
      ImageIcon(AssetImage('assets/icons/grey/bottom_bar/chat.png'), size: 24),
  'bottom_navigation.resume': ImageIcon(
      AssetImage('assets/icons/grey/bottom_bar/writing.png'),
      size: 24),
  'bottom_navigation.home':
      ImageIcon(AssetImage('assets/icons/grey/bottom_bar/home.png'), size: 24),
  'bottom_navigation.community': ImageIcon(
      AssetImage('assets/icons/grey/bottom_bar/community.png'),
      size: 24),
  'bottom_navigation.center': ImageIcon(
      AssetImage('assets/icons/grey/bottom_bar/announcement.png'),
      size: 24),
};

class CustomBottomNavigationBar extends StatelessWidget {
  final Map<String, ImageIcon> items;

  const CustomBottomNavigationBar({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final localizationService = GetIt.instance<LocalizationService>();

    // Get the keyboard visibility status
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return BlocConsumer<RouteBloc, RouteState>(
      listenWhen: (previous, current) =>
          previous.currentIndex != current.currentIndex,
      listener: (context, routeState) {
        print("Route changed to index: ${routeState.currentIndex}");
      },
      builder: (context, routeState) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height:
              isKeyboardVisible ? 0 : MediaQuery.of(context).size.height * 0.11,
          child: Padding(
            padding: EdgeInsets.only(
                // Adjust for the keyboard height if needed
                bottom: isKeyboardVisible
                    ? MediaQuery.of(context).viewInsets.bottom
                    : 0),
            child: Container(
              decoration: const BoxDecoration(
                color: HelloColors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isKeyboardVisible)
                    Expanded(
                      child: Row(
                        children: items.keys.map((key) {
                          final index = items.keys.toList().indexOf(key);
                          return Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: index == routeState.currentIndex
                                  ? Container(
                                      width: 30,
                                      height: 3,
                                      color: const Color(0xff4B7BF5),
                                    )
                                  : Container(
                                      width: 30,
                                      height: 3,
                                      color: Colors.transparent,
                                    ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  BottomNavigationBar(
                    currentIndex: routeState.currentIndex,
                    onTap: (index) {
                      final selectedKey = items.keys.elementAt(index);
                      final selectedRoute = '/${selectedKey.split('.').last}';

                      if (selectedRoute == "/community/board") {
                        router.push("/community/board");
                        return;
                      }

                      if (selectedRoute == "/consultation_center") {
                        router.push("/center");
                        return;
                      }

                      if (selectedRoute == "/resume") {
                        showToast("미구현된 기능입니다.");
                        return;
                      }

                      context.push(selectedRoute);
                      context
                          .read<RouteBloc>()
                          .add(RouteChanged(newIndex: index));
                    },
                    items: _getBottomNavItems(localizationService),
                    backgroundColor: HelloColors.white,
                    selectedItemColor: const Color(0xff4B7BF5),
                    unselectedItemColor: Colors.grey,
                    showUnselectedLabels: true,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<BottomNavigationBarItem> _getBottomNavItems(
      LocalizationService localization) {
    return items.entries.map((entry) {
      return BottomNavigationBarItem(
        icon: Padding(
          padding: const EdgeInsets.all(6.0),
          child: entry.value,
        ),
        label: localization.getTranslatedText(entry.key),
        backgroundColor: HelloColors.white,
      );
    }).toList();
  }
}
