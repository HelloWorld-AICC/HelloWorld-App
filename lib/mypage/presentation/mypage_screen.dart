import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
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
        return const Scaffold(
          bottomNavigationBar: CustomBottomNavigationBar(),
          body: Stack(
            children: [
              _BackDecoration(),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 57),
                    _PageTitle(),
                    SizedBox(height: 35),
                    _Body()
                  ],
                ),
              )
            ],
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
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        height: 741,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(
                  75, 75, 75, 0.15), // box-shadow 색상: rgba(75, 75, 75, 0.15)
              offset: Offset(0, 2), // box-shadow 위치: 0px 가로, 2px 세로
              blurRadius: 16, // box-shadow 블러 반경: 16px
              spreadRadius: 0, // box-shadow 확산 반경: 0px
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _MyProfile(),
            const _Divider(),
            const _Title(title: "상담"),
            _MyPageMenu(
              title: "상담 신청 내역",
              onTap: () {
                context.push('/consultation-history');
              },
            ),
            _MyPageMenu(
              title: "사용자 요약 정보",
              onTap: () {},
            ),
            _Divider(),
            _Title(title: "계정 설정"),
            _MyPageMenu(
              title: "프로필 변경",
              onTap: () {},
            ),
          ],
        ));
  }
}

class _MyProfile extends StatelessWidget {
  const _MyProfile();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MypageBloc, MypageState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(
            vertical: 25,
            horizontal: 24,
          ),
          child: Row(
            children: [
              // CircleAvatar(
              //   radius: 20.0,
              //   backgroundImage: NetworkImage(state.myInfo?.userImg ?? ""),
              //   backgroundColor: Colors.red,
              // ),
              const SizedBox(
                width: 12,
              ),
              Text(
                state.myInfo?.name ?? "",
                style: const TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 18,
                ),
              ),
            ],
          ),
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
  final Function onTap;
  const _MyPageMenu({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 19.0,
          vertical: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: const TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                )),
            SvgPicture.asset(
              "assets/images/mypage/right_arrow.svg",
              width: 21,
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5,
      color: const Color(0xFFCACACA),
    );
  }
}

class _PageTitle extends StatelessWidget {
  const _PageTitle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: Row(
        children: [
          SvgPicture.asset("assets/images/mypage/profile.svg"),
          const SizedBox(width: 10),
          const Text(
            "MyPage",
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 28,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.98,
            ),
          ),
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
