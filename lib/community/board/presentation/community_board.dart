import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world_mvp/common/presentation/common_appbar.dart';
import 'package:hello_world_mvp/common/presentation/hello_appbar.dart';
import 'package:hello_world_mvp/community/common/presentation/community_action_button.dart';
import 'package:hello_world_mvp/design_system/hello_colors.dart';
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
                    height: 4,
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
        MypageBox(
            child: Column(
          children: [
            Container(height: 100),
          ],
        )),
      ],
    );
  }
}
