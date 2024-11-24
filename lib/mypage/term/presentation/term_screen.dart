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
    return const Scaffold(
      backgroundColor: HelloColors.white,
      body: SingleChildScrollView(
        child: MypageBackgroundGradient(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyPageTitle(),
              SizedBox(height: 36),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Text("서비스 이용약관",
                    style: TextStyle(
                      fontFamily: HelloFonts.sbAggroOTF,
                      fontSize: 12,
                      color: HelloColors.mainColor2,
                    )),
              ),
              _Body(),
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
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24),
        MypageBox(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관 서비스 이용약관",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: HelloFonts.sbAggroOTF,
                  color: HelloColors.subTextColor,
                  fontWeight: FontWeight.w400,
                  height: 16 / 12,
                ))
          ],
        )),
        SizedBox(height: 24),
      ],
    );
  }
}
