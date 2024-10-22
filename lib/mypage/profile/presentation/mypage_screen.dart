import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world_mvp/design_system/hello_colors.dart';
import 'package:hello_world_mvp/design_system/hello_fonts.dart';
import 'package:hello_world_mvp/injection.dart';
import 'package:hello_world_mvp/mypage/common/presentation/mypage_background_gradient.dart';
import 'package:hello_world_mvp/mypage/common/presentation/mypage_title.dart';
import 'package:hello_world_mvp/mypage/profile/application/mypage/mypage_bloc.dart';

class MypageScreen extends StatelessWidget {
  const MypageScreen({super.key});

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const _MyProfile(),
          const SizedBox(height: 36),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: HelloColors.white,
              boxShadow: const [
                BoxShadow(
                  color: HelloColors.subTextColor,
                  blurRadius: 4.0,
                  spreadRadius: 0.0,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              children: [
                _MyPageMenu(
                  title: "프로필",
                  description: "프로필 변경",
                  onTap: () {
                    context.push('/consultation-history');
                  },
                ),
                const SizedBox(height: 24),
                _MyPageMenu(
                  title: "상담",
                  description: "채팅 상담 요약 확인하기",
                  onTap: () {
                    context.push('/consultation-history');
                  },
                ),
                const SizedBox(height: 24),
                _MyPageMenu(
                  title: "이력서 / 자기소개서",
                  description: "생성된 이력서 / 자기소개서 확인하기",
                  onTap: () {
                    context.push('/consultation-history');
                  },
                ),
                const SizedBox(height: 24),
                _MyPageMenu(
                  title: "커뮤니티",
                  description: "작성한 커뮤니티 게시글 / 댓글 확인하기",
                  onTap: () {
                    context.push('/consultation-history');
                  },
                ),
                const SizedBox(height: 24),
                _MyPageMenu(
                  title: "기타",
                  description: "계정 및 정보",
                  onTap: () {
                    context.push('/consultation-history');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MyProfile extends StatelessWidget {
  const _MyProfile();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MypageBloc, MypageState>(
      builder: (context, state) {
        return Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 11.0),
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(state.myInfo?.userImg ?? ""),
                  backgroundColor: Colors.red,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 102,
                height: 22,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: HelloColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: HelloColors.mainColor1.withOpacity(0.75),
                      blurRadius: 4.0,
                      spreadRadius: 0.0,
                      offset: const Offset(0, 0), // x, y 축의 그림자 위치
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    state.myInfo?.name ?? "No Profile",
                    style: const TextStyle(
                      fontFamily: HelloFonts.pretendard,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

class _Title extends StatelessWidget {
  final String title;

  const _Title({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 19.0,
        vertical: 18,
      ),
      child: Text(title,
          style: const TextStyle(
            color: Color(0xFFADADAD),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          )),
    );
  }
}

class _MyPageMenu extends StatelessWidget {
  final String title;
  final String description;
  final Function onTap;
  const _MyPageMenu({
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                fontFamily: "Pretendard",
                color: HelloColors.mainColor1,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              )),
          const SizedBox(height: 12),
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
              SvgPicture.asset(
                "assets/images/mypage/right_arrow.svg",
                width: 6.5,
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
