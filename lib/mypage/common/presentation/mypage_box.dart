import 'package:flutter/material.dart';
import 'package:hello_world_mvp/design_system/hello_colors.dart';

class MypageBox extends StatelessWidget {
  final Widget child;

  const MypageBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: HelloColors.white,
        boxShadow: const [
          BoxShadow(
            color: HelloColors.subTextColor,
            blurRadius: 4.0,
            spreadRadius: 0.0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: child,
    );
  }
}
