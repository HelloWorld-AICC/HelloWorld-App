import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world_mvp/design_system/hello_colors.dart';
import 'package:hello_world_mvp/toast/common_toast.dart';

import 'locale/domain/localization_service.dart';
import 'route/application/route_bloc.dart';

final Map<String, ImageIcon> bottomNavItems = {
  'bottom_navigation.chat':
      ImageIcon(AssetImage('assets/icons/grey/chat.png'), size: 24),
  'bottom_navigation.resume':
      ImageIcon(AssetImage('assets/icons/grey/writing.png'), size: 24),
  'bottom_navigation.home':
      ImageIcon(AssetImage('assets/icons/grey/home.png'), size: 24),
  'bottom_navigation.community':
      ImageIcon(AssetImage('assets/icons/grey/community.png'), size: 32),
  'bottom_navigation.center':
      ImageIcon(AssetImage('assets/icons/grey/announcement.png'), size: 24),
};

class CustomBottomNavigationBar extends StatelessWidget {
  final Map<String, ImageIcon> items;

  const CustomBottomNavigationBar({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final localizationService = GetIt.instance<LocalizationService>();

    return BlocBuilder<RouteBloc, RouteState>(
      builder: (context, routeState) {
        return FractionallySizedBox(
          heightFactor: MediaQuery.sizeOf(context).height < 600 ? 0.10 : 0.08,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: HelloColors.white,
                tooltipTheme: TooltipThemeData(
                  textStyle: TextStyle(
                    fontSize: 8,
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Row(
                      children: items.keys.map((key) {
                        final index = items.keys.toList().indexOf(key);
                        return Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: index == routeState.currentIndex
                                ? Container(
                                    width: 40,
                                    height: 4,
                                    color: Color(0xff4B7BF5),
                                  )
                                : SizedBox(width: 40),
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

                      if (selectedRoute == "/consultation_center" ||
                          selectedRoute == "/community" ||
                          selectedRoute == "/resume") {
                        showToast("미구현된 기능입니다.");
                        return;
                      }
                      context.read<RouteBloc>().add(RouteChanged(
                          newIndex: index, newRoute: selectedRoute));
                      Future.delayed(Duration(milliseconds: 100), () {
                        context.push(selectedRoute);
                      });
                    },
                    items: _getBottomNavItems(localizationService),
                    backgroundColor: HelloColors.white,
                    selectedItemColor: Color(0xff4B7BF5),
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
          padding: const EdgeInsets.all(8.0),
          child: entry.value,
        ),
        label: localization.getTranslatedText(entry.key),
        tooltip: localization.getTranslatedText(entry.key),
      );
    }).toList();
  }
}
