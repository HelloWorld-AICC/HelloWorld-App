import 'package:flutter/material.dart';
import 'package:hello_world_mvp/design_system/hello_colors.dart';
import 'package:hello_world_mvp/design_system/hello_fonts.dart';

enum Language {
  korean(flagAssetPath: "icons/flags/png100px/kr.png"),
  chinese(flagAssetPath: "icons/flags/png100px/cn.png"),
  vietnamese(flagAssetPath: "icons/flags/png100px/vn.png"),
  japanese(flagAssetPath: "icons/flags/png100px/jp.png"),
  english(flagAssetPath: "icons/flags/png100px/us.png");

  final String flagAssetPath;

  const Language({required this.flagAssetPath});
}

class LanguageFlag extends StatelessWidget {
  final Language lanagaue;
  const LanguageFlag({
    super.key,
    required this.lanagaue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 44,
        height: 48,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: HelloColors.mainBlue,
                ),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child:
                  Image.asset(lanagaue.flagAssetPath, package: 'country_icons'),
            ),
            const SizedBox(height: 4),
            Text(lanagaue.name,
                style: const TextStyle(
                  color: HelloColors.subTextColor,
                  fontFamily: HelloFonts.pretendard,
                  fontSize: 8,
                  fontWeight: FontWeight.w400,
                )),
          ],
        ));
  }
}
