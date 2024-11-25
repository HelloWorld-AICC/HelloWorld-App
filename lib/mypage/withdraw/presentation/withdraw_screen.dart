import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world_mvp/design_system/hello_colors.dart';
import 'package:hello_world_mvp/design_system/hello_fonts.dart';
import 'package:hello_world_mvp/injection.dart';
import 'package:hello_world_mvp/mypage/common/presentation/my_profile.dart';
import 'package:hello_world_mvp/mypage/common/presentation/mypage_background_gradient.dart';
import 'package:hello_world_mvp/mypage/common/presentation/mypage_box.dart';
import 'package:hello_world_mvp/mypage/common/presentation/mypage_title.dart';
import 'package:hello_world_mvp/mypage/menu/application/mypage/mypage_bloc.dart';
import 'package:hello_world_mvp/mypage/withdraw/application/withdraw_bloc.dart';

class WithdrawScreen extends StatelessWidget {
  const WithdrawScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<MypageBloc>()..add(GetMyInfo()),
        ),
        BlocProvider(create: (context) => getIt<WithdrawBloc>()),
      ],
      child: Builder(builder: (context) {
        return BlocListener<WithdrawBloc, WithdrawState>(
          listenWhen: (prev, next) {
            return (prev.isWithdrawn != next.isWithdrawn) &&
                next.isWithdrawn == true;
          },
          listener: (context, state) {
            while (context.canPop()) {
              context.pop();
            }
            context.push("/login");
          },
          child: const Scaffold(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.tr("mypage_withdraw_title"),
              style: const TextStyle(
                fontFamily: "Pretendard",
                color: HelloColors.mainColor1,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Text(context.tr("mypage_withdraw_body"),
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: HelloFonts.sbAggroOTF,
                  color: HelloColors.subTextColor,
                  fontWeight: FontWeight.w400,
                  height: 16 / 12,
                )),
          ],
        )),
        const SizedBox(height: 24),
        const WithdrawButton()
      ],
    );
  }
}

class WithdrawButton extends StatelessWidget {
  const WithdrawButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<WithdrawBloc>().add(Confirmed());
      },
      child: Container(
          height: 41,
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            color: HelloColors.mainBlue,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              context.tr("mypage_withdraw_confirm_button"),
              style: const TextStyle(
                fontFamily: HelloFonts.sbAggroOTF,
                fontSize: 12,
                height: 12 / 12,
                color: HelloColors.subTextColor,
              ),
            ),
          )),
    );
  }
}
