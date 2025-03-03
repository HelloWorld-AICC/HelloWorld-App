import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hello_world_mvp/design_system/hello_colors.dart';

class MypageMenu extends StatelessWidget {
  final String? title;
  final String description;
  final Function? onTap;
  final String? value;
  MypageMenu({
    super.key,
    this.title,
    required this.description,
    this.onTap,
    this.value,
  }) {
    assert(!(onTap != null && value != null));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap?.call(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) ...[
              Text(title!,
                  style: const TextStyle(
                    fontFamily: "Pretendard",
                    color: HelloColors.mainColor1,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  )),
              const SizedBox(height: 12),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(description,
                    style: const TextStyle(
                      fontFamily: "Pretendard",
                      color: HelloColors.subTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    )),
                if (onTap != null)
                  SvgPicture.asset(
                    "assets/images/mypage/right_arrow.svg",
                    width: 6.5,
                    height: 10,
                  ),
                if (value != null)
                  Text(value ?? "",
                      style: const TextStyle(
                        fontFamily: "Pretendard",
                        color: HelloColors.subTextColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
