import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world_mvp/common/presentation/hello_appbar.dart';
import 'package:hello_world_mvp/community/board/applicatioin/board_bloc.dart';
import 'package:hello_world_mvp/community/board/presentation/widgets/board_tab.dart';
import 'package:hello_world_mvp/community/board/presentation/widgets/post.dart';
import 'package:hello_world_mvp/community/common/presentation/community_action_button.dart';
import 'package:hello_world_mvp/design_system/hello_colors.dart';
import 'package:hello_world_mvp/injection.dart';
import 'package:hello_world_mvp/mypage/common/presentation/mypage_background_gradient.dart';
import 'package:hello_world_mvp/mypage/common/presentation/mypage_box.dart';
import "dart:math" as math;

import '../../../custom_bottom_navigationbar.dart';
import '../../../route/application/route_bloc.dart';

enum PostCategory {
  suffering(title: "직장 내 고충", id: 0),
  meical(title: "산재 및 의료", id: 1),
  visa(title: "체류 및 근로자격", id: 2),
  etc(title: "기타", id: 3);

  final String title;
  final int id;

  const PostCategory({required this.title, required this.id});
}

class CommunityBoard extends StatelessWidget {
  const CommunityBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<BoardBloc>()..add(GetPosts()),
      child: Builder(builder: (context) {
        return PopScope(
          onPopInvoked: (result) {},
          child: Scaffold(
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
            body: CustomMaterialIndicator(
              onRefresh: () {
                context.read<BoardBloc>().add(GetPosts());
                return Future.value();
              }, // Your refresh logic
              backgroundColor: Colors.white,
              indicatorBuilder: (context, controller) {
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: CircularProgressIndicator(
                    color: HelloColors.mainBlue,
                    value: controller.state.isLoading
                        ? null
                        : math.min(controller.value, 1.0),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    BlocBuilder<BoardBloc, BoardState>(
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...PostCategory.values.map((board) => BoardTab(
                                  title: board.title,
                                  onTap: () {
                                    context
                                        .read<BoardBloc>()
                                        .add(SelectBoard(category: board));
                                  },
                                  isSelected:
                                      board.id == state.selectedBoard.id,
                                )),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    const Flexible(
                      child: SingleChildScrollView(
                        child: MypageBackgroundGradient(
                          child: Column(
                            children: [
                              _Body(),
                            ],
                          ),
                        ),
                      ),
                    ),
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

  get math => null;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 9),
        BlocBuilder<BoardBloc, BoardState>(
          builder: (context, state) {
            return MypageBox(
                child: Column(
              children: [
                const SizedBox(height: 2),
                state.postList?.posts.isEmpty ?? true
                    ? Container(
                        height: MediaQuery.of(context).size.height *
                            0.5, // Adjust height as needed
                        alignment: Alignment.center,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage(
                                  "assets/images/community/caution.png"),
                              width: 50,
                              height: 50,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              textAlign: TextAlign.center,
                              "아직 게시물이 없어요.\n첫 번째 게시물을 작성해보세요!",
                              style: TextStyle(
                                fontSize: 12,
                                color: HelloColors.subTextColor,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.postList?.posts.length ?? 0,
                        itemBuilder: (context, index) {
                          return PostItem(
                            post: state.postList!.posts[index],
                            postCategory: state.selectedBoard,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(top: 16, bottom: 16),
                            height: 0.4,
                            color: const Color(0xFF919191).withOpacity(0.8),
                          );
                        },
                      )
              ],
            ));
          },
        ),
      ],
    );
  }
}
