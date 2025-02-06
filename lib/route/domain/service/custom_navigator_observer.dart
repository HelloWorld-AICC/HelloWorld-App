import 'package:flutter/material.dart';
import '../../application/route_bloc.dart';

class CustomNavigatorObserver extends NavigatorObserver {
  final RouteBloc routeBloc;

  CustomNavigatorObserver(this.routeBloc);

  @override
  void didPop(Route route, Route? previousRoute) {
    print("기존 화면으로부터 pop함");
    super.didPop(route, previousRoute);

    if (previousRoute != null) {
      final newRouteName = previousRoute.settings.name;
      final newRouteIndex = _getRouteIndex(newRouteName); // Implement this
      if (newRouteIndex != null) {
        print("newRouteIndex: $newRouteIndex, newRouteName: $newRouteName");
        routeBloc.add(
            RouteChanged(newIndex: newRouteIndex, newRoute: newRouteName!));
      }
    }
  }

  int? _getRouteIndex(String? routeName) {
    // Map route names to their corresponding indices
    const routeMap = {
      '/chat': 0,
      '/resume': 1,
      '/home': 2,
      '/community': 3,
      '/center': 4,
    };

    return routeMap[routeName];
  }
}
