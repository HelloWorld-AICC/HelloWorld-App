import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world_mvp/design_system/hello_colors.dart';
import 'package:hello_world_mvp/design_system/hello_fonts.dart';

class HelloAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? action;

  const HelloAppbar({super.key, this.action, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.only(left: 26, right: 26, top: 16, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              context.pop();
            },
            child: SvgPicture.asset(
              "assets/images/mypage/caret-left.svg",
              width: 24,
              height: 24,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontFamily: HelloFonts.sbAggroOTF,
              color: HelloColors.subTextColor,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 1.0,
            ),
          ),
          if (action != null) action! else const SizedBox()
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}
