import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world_mvp/design_system/hello_colors.dart';
import 'package:hello_world_mvp/design_system/hello_fonts.dart';

class MyPageTitle extends StatelessWidget {
  const MyPageTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 26),
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
          const Text(
            "MyPage",
            style: TextStyle(
              fontFamily: HelloFonts.sbAggroOTF,
              color: HelloColors.subTextColor,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 1.0,
            ),
          ),
          const SizedBox(width: 24, height: 24)
        ],
      ),
    );
  }
}
