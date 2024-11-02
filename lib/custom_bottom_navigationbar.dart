import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world_mvp/design_system/hello_colors.dart';

import 'locale/domain/localization_service.dart';
import 'route/application/route_bloc.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final Map<String, ImageIcon> items;

  const CustomBottomNavigationBar({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final localizationService = GetIt.instance<LocalizationService>();

    return BlocBuilder<RouteBloc, RouteState>(
      builder: (context, routeState) {
        return FractionallySizedBox(
          heightFactor: 0.1,
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
                Row(
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
                BottomNavigationBar(
                  currentIndex: routeState.currentIndex,
                  onTap: (index) {
                    final selectedKey = items.keys.elementAt(index);
                    final selectedRoute = '/${selectedKey.split('.').last}';
                    context.read<RouteBloc>().add(
                        RouteChanged(newIndex: index, newRoute: selectedRoute));
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
