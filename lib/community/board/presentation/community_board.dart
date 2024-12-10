import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world_mvp/common/presentation/common_appbar.dart';
import 'package:hello_world_mvp/common/presentation/hello_appbar.dart';
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
                return Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("1경기 전력 어떻게 봐 ?",
                            style: TextStyle(
                              fontFamily: HelloFonts.inter,
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              height: 12 / 12,
                              letterSpacing: 0.12,
                            )),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Text("2024.03.08",
                                style: TextStyle(
                                  fontFamily: HelloFonts.inter,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w400,
                                  height: 10 / 8,
                                  letterSpacing: 0.08,
                                )),
                            const SizedBox(width: 12),
                            SvgPicture.asset(
                                "assets/images/community/comment.svg"),
                            const SizedBox(width: 2),
                            const Text("39",
                                style: TextStyle(
                                  color: HelloColors.gray,
                                  fontFamily: HelloFonts.inter,
                                  fontSize: 6,
                                  fontWeight: FontWeight.w400,
                                  height: 4 / 6,
                                  letterSpacing: 0.06,
                                ))
                          ],
                        )
                      ],
                    ),
                    Container(
                      width: 21,
                      height: 21,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4.0)),
                    )
                  ],
                ));
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

class BoardTab extends StatelessWidget {
  final String title;
  final Function onTap;
  final bool isSelected;
  const BoardTab({
    super.key,
    required this.title,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: InkWell(
        onTap: () => onTap(),
        child: Text(title,
            style: TextStyle(
              color: isSelected
                  ? HelloColors.subTextColor
                  : const Color(0xFFB2B2B2),
              fontFamily: HelloFonts.sbAggroOTF,
              fontSize: 12,
              height: 16 / 12,
            )),
      ),
    );
  }
}
