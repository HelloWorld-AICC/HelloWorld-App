import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world_mvp/design_system/hello_colors.dart';
import 'package:hello_world_mvp/injection.dart';
import 'package:hello_world_mvp/mypage/account/presentation/widgets/signout_dialog.dart';
import 'package:hello_world_mvp/mypage/app_version/application/app_version_bloc.dart';
import 'package:hello_world_mvp/mypage/common/presentation/mypage_menu.dart';
import 'package:hello_world_mvp/mypage/common/presentation/my_profile.dart';
import 'package:hello_world_mvp/mypage/common/presentation/mypage_background_gradient.dart';
import 'package:hello_world_mvp/mypage/common/presentation/mypage_box.dart';
import 'package:hello_world_mvp/mypage/common/presentation/mypage_title.dart';
import 'package:hello_world_mvp/mypage/menu/application/mypage/mypage_bloc.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MypageBloc>()..add(GetMyInfo()),
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
              title: context.tr("mypage_account_account"),
              description: context.tr("mypage_account_logout"),
              onTap: () {
                showSignOutDailog(context);
              },
            ),
            MypageMenu(
              description: context.tr("mypage_account_withdraw"),
              onTap: () {
                context.push("/withdraw");
              },
            ),
            BlocProvider<AppVersionBloc>(
              create: (context) =>
                  getIt<AppVersionBloc>()..add(GetAppVersion()),
              child: Builder(builder: (context) {
                return BlocBuilder<AppVersionBloc, AppVersionState>(
                  builder: (context, state) {
                    return MypageMenu(
                        title:
                            "${context.tr('mypage_account_helloWorld')} ${context.tr('mypage_account_infomation')}",
                        description: context.tr("mypage_account_appversion"),
                        value: state.appVersion);
                  },
                );
              }),
            ),
            MypageMenu(
              description: context.tr("mypage_account_terms"),
              onTap: () {
                context.push("/term");
              },
            ),
            MypageMenu(
              description: context.tr("mypage_account_privacy_policy"),
              onTap: () {
                context.push("/privacy-policy");
              },
            ),
            // const SizedBox(height: 24),
            // MypageMenu(
            //   description: "오픈소스 라이선스",
            //   onTap: () {},
            // )
          ],
        )),
      ],
    );
  }
}
