import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hello_world_mvp/design_system/hello_colors.dart';
import 'package:hello_world_mvp/design_system/hello_fonts.dart';

enum Language {
  korean(
      flagAssetPath: "assets/images/common/flags/korean.png",
      offFlagAssetPath: "assets/images/common/flags/korean_off.png",
      languageCode: "ko",
      contryCode: "KR",
      languageName: "한국어"),
  chinese(
    flagAssetPath: "assets/images/common/flags/chinese.png",
    offFlagAssetPath: "assets/images/common/flags/chinese_off.png",
    languageCode: "zh",
    contryCode: "CN",
    languageName: "中文",
  ),
  vietnamese(
      flagAssetPath: "assets/images/common/flags/vietnamese.png",
      offFlagAssetPath: "assets/images/common/flags/vietnamese_off.png",
      languageCode: "vi",
      contryCode: "VN",
      languageName: "Tiếng Việt"),
  japanese(
    flagAssetPath: "assets/images/common/flags/japanese.png",
    offFlagAssetPath: "assets/images/common/flags/japanese_off.png",
    languageCode: "ja",
    contryCode: "JP",
    languageName: "日本語",
  ),
  english(
    flagAssetPath: "assets/images/common/flags/english.png",
    offFlagAssetPath: "assets/images/common/flags/english_off.png",
    languageCode: "en",
    contryCode: "US",
    languageName: "English",
  );

  final String flagAssetPath;
  final String offFlagAssetPath;
  final String languageCode;
  final String contryCode;
  final String languageName;

  const Language({
    required this.flagAssetPath,
    required this.offFlagAssetPath,
    required this.languageCode,
    required this.contryCode,
    required this.languageName,
  });
}

class LanguageFlag extends StatelessWidget {
  final Language lanagaue;
  const LanguageFlag({
    super.key,
    required this.lanagaue,
  });

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;

    return InkWell(
      onTap: () async {
        await context
            .setLocale(Locale(lanagaue.languageCode, lanagaue.contryCode));
        // context.read<LocaleBloc>().add(SetLocale(
        //     locale: Locale(lanagaue.languageCode, lanagaue.contryCode),
        //     index: 0));
      },
      child: Container(
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
                child: Image.asset(
                  locale.languageCode == lanagaue.languageCode
                      ? lanagaue.flagAssetPath
                      : lanagaue.offFlagAssetPath,
                ),
              ),
              const SizedBox(height: 4),
              Text(lanagaue.languageName,
                  style: const TextStyle(
                    color: HelloColors.subTextColor,
                    fontFamily: HelloFonts.pretendard,
                    fontSize: 8,
                    fontWeight: FontWeight.w400,
                  )),
            ],
          )),
    );
  }
}
