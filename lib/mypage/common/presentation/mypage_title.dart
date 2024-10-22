import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world_mvp/design_system/hello_colors.dart';
import 'package:hello_world_mvp/design_system/hello_fonts.dart';

class MyPageTitle extends StatelessWidget {
  final Function? onTapConfirm;
  const MyPageTitle({super.key, this.onTapConfirm});

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
          if (onTapConfirm != null)
            InkWell(
              onTap: () => onTapConfirm!(),
              child: Container(
                width: 20,
                height: 20,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                decoration: BoxDecoration(
                  color: HelloColors.subTextColor,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: SvgPicture.asset(
                  width: 12,
                  height: 9,
                  "assets/images/mypage/check.svg",
                  colorFilter: const ColorFilter.mode(
                    HelloColors.white,
                    BlendMode.srcIn, // 색상을 덮어쓸 때 사용하는 BlendMode
                  ),
                ),
              ),
            )
          else
            const SizedBox(width: 24, height: 24)
        ],
      ),
    );
  }
}
