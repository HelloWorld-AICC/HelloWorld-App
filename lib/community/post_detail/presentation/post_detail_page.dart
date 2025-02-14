import 'dart:io';

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/common/presentation/hello_appbar.dart';
import 'package:hello_world_mvp/community/common/presentation/community_action_button.dart';
import 'package:hello_world_mvp/community/common/presentation/section_title.dart';
import 'package:hello_world_mvp/community/create_post/application/create_post_bloc.dart';
import 'package:hello_world_mvp/community/post_detail/application/post_detail_bloc.dart';
import 'package:hello_world_mvp/community/post_detail/presentation/widgets/comment_input_button.dart';
import 'package:hello_world_mvp/community/post_detail/presentation/widgets/comment_list_widget.dart';
import 'package:hello_world_mvp/community/post_detail/presentation/widgets/video_preview.dart';
import 'package:hello_world_mvp/design_system/hello_colors.dart';
import 'package:hello_world_mvp/design_system/hello_fonts.dart';
import 'package:hello_world_mvp/injection.dart';
import 'package:hello_world_mvp/mypage/common/presentation/mypage_background_gradient.dart';
import 'package:hello_world_mvp/mypage/common/presentation/mypage_box.dart';
import 'package:image_picker/image_picker.dart';
import "dart:math" as math;

import '../../../custom_bottom_navigationbar.dart';
import '../../../route/application/route_bloc.dart';
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
          categoryId: widget.categoryId,
          postId: widget.postId,
        )),
      child: BlocBuilder<PostDetailBloc, PostDetailState>(
          builder: (context, state) {
        return PopScope(
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
            body: CustomMaterialIndicator(
              onRefresh: () {
                context.read<PostDetailBloc>().add(PostDetailFetched(
                      categoryId: widget.categoryId,
                      postId: widget.postId,
                    ));
                return Future.value();
              },
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
              child: BlocBuilder<PostDetailBloc, PostDetailState>(
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
            ),
            bottomSheet: Container(
              decoration: const BoxDecoration(color: Color(0xffECF6FE)),
              child: CommentInputButton(
                postId: widget.postId,
                categoryId: widget.categoryId,
              ),
            ),
          ),
        );
      }),
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

    List<XFile> images = context.read<PostDetailBloc>().state.medias;
    // print("all images are, ${images.map((e) => e.path)}");

    return Padding(
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
                      text: context.read<PostDetailBloc>().state.title ??
                          "No title"),
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
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.12,
                  )),
              const SizedBox(height: 3),
              Text(
                context.read<PostDetailBloc>().state.body ?? "No content",
                style: const TextStyle(
                  color: HelloColors.subTextColor,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.12,
                ),
              ),
              const SizedBox(height: 21),
              SizedBox(
                height: 60,
                child: images.isEmpty
                    // Case 1: images is empty, show a container
                    ? const Center(
                        child: CircularProgressIndicator(
                            color: HelloColors.mainBlue, strokeWidth: 2),
                      )
                    : images[0].path == "NULL"
                        // Case 2: images is not empty, but the first item is "Null", show nothing
                        ? Container()
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, // Number of columns
                              crossAxisSpacing: 8.0, // Spacing between columns
                              mainAxisSpacing: 8.0, // Spacing between rows
                              childAspectRatio: 1, // Aspect ratio of grid items
                            ),
                            itemCount: images.length,
                            itemBuilder: (BuildContext context, int index) {
                              final media = images[index];
                              print("media path: ${media.path}");

                              // Define the condition to check if it's a video
                              final isVideo =
                                  true; // Replace with real video checking logic

                              if (isVideo) {
                                return VideoPreview(videoUrl: media.path);
                              } else {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(4.0),
                                    image: DecorationImage(
                                      image: FileImage(File(media.path)),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
              ),
              const SizedBox(height: 13),
            ],
          )),
          const SizedBox(height: 15),
          CommentListWidget(),
        ],
      ),
    );
  }
}
