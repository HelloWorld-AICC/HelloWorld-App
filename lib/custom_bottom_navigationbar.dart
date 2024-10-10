import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'locale/domain/localization_service.dart';
import 'route/application/route_bloc.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final Map<String, IconData> items;

  const CustomBottomNavigationBar({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final localizationService = GetIt.instance<LocalizationService>();

    return BlocBuilder<RouteBloc, RouteState>(
      builder: (context, routeState) {
        print("current index: ${routeState.currentIndex}");

        return BottomNavigationBar(
          currentIndex: routeState.currentIndex,
          onTap: (index) {
            final selectedKey = items.keys.elementAt(index);
            final selectedRoute = '/${selectedKey.split('.').last}';
            context
                .read<RouteBloc>()
                .add(RouteChanged(newIndex: index, newRoute: selectedRoute));
            context.push(selectedRoute);
          },
          items: _getBottomNavItems(localizationService),
          backgroundColor: Colors.transparent,
          selectedItemColor: Color(0xff4B7BF5),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
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
          child: Icon(entry.value),
        ),
        label: localization.getTranslatedText(entry.key), // 번역된 텍스트
      );
    }).toList();
  }
}
