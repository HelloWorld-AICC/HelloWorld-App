import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world_mvp/common/presentation/common_appbar.dart';
import 'package:hello_world_mvp/common/presentation/hello_appbar.dart';
import 'package:hello_world_mvp/community/board/presentation/widgets/board_tab.dart';
import 'package:hello_world_mvp/community/board/presentation/widgets/post.dart';
import 'package:hello_world_mvp/community/common/presentation/community_action_button.dart';
import 'package:hello_world_mvp/design_system/hello_colors.dart';
import 'package:hello_world_mvp/design_system/hello_fonts.dart';
import 'package:hello_world_mvp/injection.dart';
import 'package:hello_world_mvp/mypage/common/presentation/mypage_background_gradient.dart';
import 'package:hello_world_mvp/mypage/common/presentation/mypage_box.dart';
import 'package:hello_world_mvp/mypage/common/presentation/mypage_title.dart';
import 'package:hello_world_mvp/mypage/menu/application/mypage/mypage_bloc.dart';

class CommunityBoard extends StatelessWidget {
  const CommunityBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MypageBloc>()..add(GetMyInfo()),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: HelloAppbar(
            title: "Community",
            action: CommunityActionButton(
              text: "글 작성",
              buttonColor: HelloColors.subTextColor,
              onTap: () {
                context.push('/community/create-post');
              },
            ),
          ),
          backgroundColor: HelloColors.white,
          body: const SingleChildScrollView(
            child: MypageBackgroundGradient(
              child: Column(
                children: [
                  SizedBox(
                    height: 21,
                  ),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BoardTab(
              title: "직장 내 고충",
              onTap: () {},
              isSelected: true,
            ),
            BoardTab(
              title: "산재 및 의료",
              onTap: () {},
              isSelected: false,
            ),
            BoardTab(
              title: "체류 및 근로 자격",
              onTap: () {},
              isSelected: false,
            ),
            BoardTab(
              title: "기타",
              onTap: () {},
              isSelected: false,
            ),
          ],
        ),
        const SizedBox(height: 29),
        MypageBox(
            child: Column(
          children: [
            const SizedBox(height: 2),
            ListView.separated(
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return const Post();
              },
              separatorBuilder: (context, index) {
                return Container(
                    margin: const EdgeInsets.only(top: 16, bottom: 16),
                    height: 0.4,
                    color: const Color(0xFF919191).withOpacity(0.8));
              },
            ),
            Container(height: 100),
          ],
        )),
      ],
    );
  }
}
