import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world_mvp/design_system/hello_colors.dart';
import 'package:hello_world_mvp/home/presentation/widget/custom_bottom_navigation_bar.dart';
import 'package:hello_world_mvp/injection.dart';
import 'package:hello_world_mvp/mypage/application/mypage/mypage_bloc.dart';

class MypageScreen extends StatelessWidget {
  const MypageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MypageBloc>()..add(GetMyInfo()),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: HelloColors.white,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: 858,
                  width: 858,
                  // color: Colors.red,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle, // border-radius: 858px와 유사한 원형 모양
                    gradient: RadialGradient(
                      center: Alignment.center, // 그라데이션 중심을 컨테이너의 중앙으로 설정
                      radius: 0.5, // 그라데이션 반지름
                      colors: [
                        Color.fromRGBO(
                            168, 196, 230, 0.20), // rgba(168, 196, 230, 0.20)
                        Color.fromRGBO(
                            173, 199, 231, 0.19), // rgba(173, 199, 231, 0.19)
                        Color.fromRGBO(
                            214, 227, 243, 0.09), // rgba(214, 227, 243, 0.09)
                        Color.fromRGBO(
                            255, 255, 255, 0.00), // rgba(255, 255, 255, 0.00)
                      ],
                      stops: [0.0, 0.2372, 0.6772, 1.0], // 각 색상이 적용될 비율
                    ),
                  ),
                ),
                const Column(
                  children: [
                    _PageTitle(),
                    SizedBox(height: 30),
                    _Body(),
                  ],
                ),
              ],
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
                      fontFamily: "Pretendard",
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

class _PageTitle extends StatelessWidget {
  const _PageTitle();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              context.pop();
            },
            child: SvgPicture.asset(
              "assets/images/mypage/caret-left.svg",
              width: 24,
              height: 24,
            ),
          ),
          const Text(
            "MyPage",
            style: TextStyle(
              fontFamily: "SB AggroOTF",
              color: HelloColors.subTextColor,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 1.0,
            ),
          ),
          const SizedBox(width: 24, height: 24)
        ],
      ),
    );
  }
}

class _BackDecoration extends StatelessWidget {
  const _BackDecoration({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 294,
      decoration: const BoxDecoration(
        color: Color(0xFF4B7bF5),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(12),
        ),
      ),
    );
  }
}
