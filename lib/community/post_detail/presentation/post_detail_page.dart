import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/common/presentation/hello_appbar.dart';
import 'package:hello_world_mvp/community/common/presentation/community_action_button.dart';
import 'package:hello_world_mvp/community/common/presentation/section_title.dart';
import 'package:hello_world_mvp/community/create_post/application/create_post_bloc.dart';
import 'package:hello_world_mvp/community/post_detail/application/post_detail_bloc.dart';
import 'package:hello_world_mvp/design_system/hello_colors.dart';
import 'package:hello_world_mvp/design_system/hello_fonts.dart';
import 'package:hello_world_mvp/injection.dart';
import 'package:hello_world_mvp/mypage/common/presentation/mypage_background_gradient.dart';
import 'package:hello_world_mvp/mypage/common/presentation/mypage_box.dart';
import "dart:math" as math;

import '../../../custom_bottom_navigationbar.dart';
import '../../board/applicatioin/board_bloc.dart';

class PostDetailPage extends StatefulWidget {
  final int postId;
  final int categoryId;

  const PostDetailPage({
    super.key,
    required this.postId,
    required this.categoryId,
  });

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PostDetailBloc>()
        ..add(PostDetailFetched(
          postId: widget.postId,
          categoryId: widget.categoryId,
        )),
      child: Scaffold(
        backgroundColor: Color(0xffECF6FE),
        appBar: HelloAppbar(
          title: "Community",
          action: CommunityActionButton(
            text: "글 신고",
            buttonColor: const Color(0xFFFF8181),
            onTap: () {
              context.read<CreatePostBloc>().add(SubmitPost());
            },
          ),
        ),
        body: BlocBuilder<PostDetailBloc, PostDetailState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: MypageBackgroundGradient(
                child: Column(
                  children: [
                    const SizedBox(height: 4),
                    _Body(
                      categoryId: widget.categoryId,
                      postId: widget.postId,
                    ),
                  ],
                ),
              ),
            ); // Default empty state
          },
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          items: bottomNavItems,
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final int postId;
  final int categoryId;

  const _Body({
    super.key,
    required this.postId,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    var createdAt = context.read<PostDetailBloc>().state.createdAt;
    DateTime dateTime = createdAt;
    String formattedDate = DateFormat('yyyy.MM.dd HH:mm').format(dateTime);

    return CustomMaterialIndicator(
      onRefresh: () {
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
        padding: const EdgeInsets.only(bottom: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            MypageBox(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SectionTitle(
                        text: context.read<PostDetailBloc>().state.title ?? ""),
                    Text(
                      formattedDate,
                      style: const TextStyle(
                        color: HelloColors.subTextColor,
                        fontFamily: HelloFonts.inter,
                        fontSize: 8,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 0.08,
                      ),
                    )
                  ],
                ),
                Container(
                  height: 1,
                  margin: const EdgeInsets.symmetric(vertical: 21),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(0, 173, 173, 173)
                          .withOpacity(0.2)),
                ),
                Text("내용",
                    style: TextStyle(
                      color: HelloColors.subTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.12,
                    )),
                const SizedBox(height: 21),
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(4.0))),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(4.0))),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(4.0))),
                    ),
                  ],
                ),
                const SizedBox(height: 13),
              ],
            )),
            const SizedBox(height: 15),
            MypageBox(
                child: ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                    height: 30,
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage(context
                              .read<PostDetailBloc>()
                              .state
                              .medias[index]
                              .path),
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(width: 4),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   context
                            //       .read<PostDetailBloc>()
                            //       .state
                            //       .medias[index]
                            //       .title,
                            //   style: const TextStyle(
                            //     color: HelloColors.subTextColor,
                            //     fontSize: 12,
                            //     fontWeight: FontWeight.w500,
                            //     letterSpacing: 0.12,
                            //   ),
                            // ),
                            // Text(
                            //   context
                            //       .read<PostDetailBloc>()
                            //       .state
                            //       .medias[index]
                            //       .content,
                            //   style: const TextStyle(
                            //     color: HelloColors.subTextColor,
                            //     fontSize: 8,
                            //     fontWeight: FontWeight.w500,
                            //     letterSpacing: 0.08,
                            //   ),
                            // ),
                          ],
                        )
                      ],
                    ));
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 16);
              },
            )),
            _buildCommentInputButton(context),
          ],
        ),
      ),
    );
  }

  _buildCommentInputButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Container(
          height: MediaQuery.sizeOf(context).height * 0.05,
          decoration: BoxDecoration(
            color: HelloColors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: HelloColors.mainBlue,
              width: 1,
            ),
            boxShadow: const [
              BoxShadow(
                color: HelloColors.subTextColor,
                blurRadius: 4.0,
                spreadRadius: 0.0,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.7,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "댓글을 입력해주세요",
                        hintStyle: TextStyle(
                          fontFamily: HelloFonts.sbAggroOTF,
                          color: HelloColors.subTextColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset("assets/icons/upload_button.png"),
                  color: HelloColors.mainBlue,
                ),
              ],
            ),
          )),
    );
  }
}
