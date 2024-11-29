import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world_mvp/design_system/hello_colors.dart';
import 'package:hello_world_mvp/design_system/hello_fonts.dart';
import 'package:hello_world_mvp/injection.dart';
import 'package:hello_world_mvp/mypage/common/presentation/my_profile.dart';
import 'package:hello_world_mvp/mypage/common/presentation/mypage_background_gradient.dart';
import 'package:hello_world_mvp/mypage/common/presentation/mypage_box.dart';
import 'package:hello_world_mvp/mypage/common/presentation/mypage_menu.dart';
import 'package:hello_world_mvp/mypage/common/presentation/mypage_title.dart';
import 'package:hello_world_mvp/mypage/menu/application/mypage/mypage_bloc.dart';

class MypageMenuScreen extends StatelessWidget {
  const MypageMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MypageBloc>()..add(GetMyInfo()),
      child: Builder(builder: (context) {
        return const Scaffold(
          backgroundColor: HelloColors.white,
          body: SingleChildScrollView(
            child: MypageBackgroundGradient(
              child: Column(
                children: [
                  MyPageTitle(),
                  SizedBox(height: 30),
                  _Body(),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BlocBuilder<MypageBloc, MypageState>(
          builder: (context, state) {
            return MyProfile(
                selectedImage: null,
                userImg: state.myInfo?.userImg,
                name: state.myInfo?.name);
          },
        ),
        const SizedBox(height: 36),
        MypageBox(
            child: Column(
          children: [
            MypageMenu(
              title: "프로필",
              description: "프로필 변경",
              onTap: () {
                context.push('/edit-profile');
              },
            ),
            // const SizedBox(height: 24),
            // MypageMenu(
            //   title: "상담",
            //   description: "채팅 상담 요약 확인하기",
            //   onTap: () {
            //     context.push('/consultation-history');
            //   },
            // ),
            // const SizedBox(height: 24),
            // MypageMenu(
            //   title: "이력서 / 자기소개서",
            //   description: "생성된 이력서 / 자기소개서 확인하기",
            //   onTap: () {
            //     context.push('/consultation-history');
            //   },
            // ),
            // const SizedBox(height: 24),
            // MypageMenu(
            //   title: "커뮤니티",
            //   description: "작성한 커뮤니티 게시글 / 댓글 확인하기",
            //   onTap: () {
            //     context.push('/consultation-history');
            //   },
            // ),
            MypageMenu(
              title: "기타",
              description: "계정 및 정보",
              onTap: () {
                context.push('/account');
              },
            ),
          ],
        )),
      ],
    );
  }
}
