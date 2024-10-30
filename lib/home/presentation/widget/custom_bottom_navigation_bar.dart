import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xFFFDFDFD),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _BottomNavigationItem(
              onTap: () {},
              iconPath: "assets/images/home/bottom_navigation_bar/chatbot.svg",
            ),
            _BottomNavigationItem(
              onTap: () {},
              iconPath: "assets/images/home/bottom_navigation_bar/map.svg",
            ),
            _BottomNavigationItem(
              onTap: () {
                context.push("/mypage-menu");
              },
              iconPath: "assets/images/home/bottom_navigation_bar/mypage.svg",
            ),
          ],
        ));
  }
}

class _BottomNavigationItem extends StatelessWidget {
  final String iconPath;
  final Function onTap;
  const _BottomNavigationItem({
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onTap(),
        child: Container(
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset(iconPath, width: 24, height: 24)));
  }
}
