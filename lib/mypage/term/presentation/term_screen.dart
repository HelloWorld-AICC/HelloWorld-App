import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hello_world_mvp/design_system/hello_colors.dart';
import 'package:hello_world_mvp/design_system/hello_fonts.dart';
import 'package:hello_world_mvp/mypage/common/presentation/mypage_background_gradient.dart';
import 'package:hello_world_mvp/mypage/common/presentation/mypage_box.dart';
import 'package:hello_world_mvp/mypage/common/presentation/mypage_title.dart';

class TermScreen extends StatelessWidget {
  const TermScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HelloColors.white,
      body: SingleChildScrollView(
        child: MypageBackgroundGradient(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MyPageTitle(),
              const SizedBox(height: 36),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(context.tr("mypage_terms_title"),
                    style: const TextStyle(
                      fontFamily: HelloFonts.sbAggroOTF,
                      fontSize: 12,
                      color: HelloColors.mainColor2,
                    )),
              ),
              const _Body(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        MypageBox(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.tr("mypage_terms_body"),
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: HelloFonts.sbAggroOTF,
                  color: HelloColors.subTextColor,
                  fontWeight: FontWeight.w400,
                  height: 16 / 12,
                ))
          ],
        )),
        const SizedBox(height: 24),
      ],
    );
  }
}
