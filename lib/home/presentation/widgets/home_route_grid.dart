import 'package:flutter/material.dart';

import '../../../route/domain/navigation_service.dart';
import 'home_route_item.dart';

class HomeRouteGrid extends StatelessWidget {
  final List<String> images;
  final List<String> items;
  final NavigationService navigationService;

  HomeRouteGrid(
      {Key? key,
      required this.images,
      required this.items,
      required this.navigationService})
      : super(key: key);

  List<String> _routePath(int index) {
    final List<String> paths = ['/chat', '/callbot', '/resume', '/job'];
    return (index >= 0 && index < paths.length) ? [paths[index]] : [paths.last];
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 1.2,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return HomeRouteItem(
            index: index,
            assetName: images[index],
            itemName: items[index],
            path: _routePath(index).first,
            navigationService: navigationService,
          );
        },
      ),
    );
  }
}
