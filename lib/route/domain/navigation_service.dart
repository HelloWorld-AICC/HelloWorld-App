import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class NavigationService {
  final BuildContext context;

  NavigationService(this.context);

  void navigateTo(String route) {
    context.push(route);
  }
}
