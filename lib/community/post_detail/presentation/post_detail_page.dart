import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/common/presentation/hello_appbar.dart';
import 'package:hello_world_mvp/community/common/domain/post.dart';
import 'package:hello_world_mvp/community/common/presentation/community_action_button.dart';
import 'package:hello_world_mvp/community/common/presentation/section_title.dart';
import 'package:hello_world_mvp/community/create_post/application/create_post_bloc.dart';
import 'package:hello_world_mvp/community/post_detail/application/post_detail_bloc.dart';
import 'package:hello_world_mvp/design_system/hello_colors.dart';
import 'package:hello_world_mvp/design_system/hello_fonts.dart';
import 'package:hello_world_mvp/injection.dart';
import 'package:hello_world_mvp/mypage/common/presentation/mypage_background_gradient.dart';
import 'package:hello_world_mvp/mypage/common/presentation/mypage_box.dart';

class PostDetailPage extends StatelessWidget {
  final int postId;
  final int categoryId;
  const PostDetailPage({
    super.key,
    required this.postId,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PostDetailBloc>(),
      child: Builder(builder: (context) {
        return Scaffold(
            appBar: HelloAppbar(
              title: "Community",
              action: CommunityActionButton(
                  text: "글 신고",
                  buttonColor: const Color(0xFFFF8181),
                  onTap: () {
                    context.read<CreatePostBloc>().add(SubmitPost());
                  }),
            ),
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
            ));
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
      mainAxisSize: MainAxisSize.min,
      children: [
        MypageBox(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SectionTitle(text: ""),
                // Text(
                //   DateFormat('yyyy.MM.dd hh:mm').format(""),
                //   style: const TextStyle(
                //     color: HelloColors.subTextColor,
                //     fontFamily: HelloFonts.inter,
                //     fontSize: 8,
                //     fontWeight: FontWeight.normal,
                //     letterSpacing: 0.08,
                //   ),
                // )
              ],
            ),
            Container(
              height: 1,
              margin: const EdgeInsets.symmetric(vertical: 21),
              decoration: BoxDecoration(
                  color:
                      const Color.fromARGB(0, 173, 173, 173).withOpacity(0.2)),
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
              height: 10,
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 16);
          },
        ))
      ],
    );
  }
}
