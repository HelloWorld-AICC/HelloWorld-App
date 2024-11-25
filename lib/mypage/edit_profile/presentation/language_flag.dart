import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/design_system/hello_colors.dart';
import 'package:hello_world_mvp/design_system/hello_fonts.dart';
import 'package:hello_world_mvp/init/presentation/splash_page.dart';
import 'package:hello_world_mvp/locale/application/locale_bloc.dart';

enum Language {
  korean(
      flagAssetPath: "icons/flags/png100px/kr.png",
      languageCode: "en",
      contryCode: "US"),
  chinese(
      flagAssetPath: "icons/flags/png100px/cn.png",
      languageCode: "zh",
      contryCode: "CN"),
  vietnamese(
      flagAssetPath: "icons/flags/png100px/vn.png",
      languageCode: "vi",
      contryCode: "VN"),
  japanese(
      flagAssetPath: "icons/flags/png100px/jp.png",
      languageCode: "ja",
      contryCode: "JP"),
  english(
    flagAssetPath: "icons/flags/png100px/us.png",
    languageCode: "en",
    contryCode: "US",
  );

  final String flagAssetPath;
  final String languageCode;
  final String contryCode;

  const Language({
    required this.flagAssetPath,
    required this.languageCode,
    required this.contryCode,
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
                child: Image.asset(lanagaue.flagAssetPath,
                    package: 'country_icons'),
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
          )),
    );
  }
}
