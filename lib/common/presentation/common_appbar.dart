import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 24.0, right: 24.0, top: 24.0, bottom: 13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: SvgPicture.asset("assets/images/common/back.svg")),
          const SizedBox(width: 28.33),
          const Text(
            "최근 상담 신청자 목록",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}
