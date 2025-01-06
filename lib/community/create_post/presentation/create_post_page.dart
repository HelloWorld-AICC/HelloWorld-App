import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world_mvp/common/presentation/hello_appbar.dart';
import 'package:hello_world_mvp/community/common/presentation/community_action_button.dart';
import 'package:hello_world_mvp/community/common/presentation/custom_text_form_field.dart';
import 'package:hello_world_mvp/community/common/presentation/section_title.dart';
import 'package:hello_world_mvp/community/create_post/application/create_post_bloc.dart';
import 'package:hello_world_mvp/design_system/hello_colors.dart';
import 'package:hello_world_mvp/design_system/hello_fonts.dart';
import 'package:hello_world_mvp/injection.dart';
import 'package:hello_world_mvp/mypage/common/presentation/mypage_background_gradient.dart';
import 'package:hello_world_mvp/mypage/common/presentation/mypage_box.dart';
import 'package:hello_world_mvp/toast/common_toast.dart';

class CreatePostPage extends StatelessWidget {
  const CreatePostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CreatePostBloc>(),
      child: Builder(builder: (context) {
        return MultiBlocListener(
          listeners: [
            BlocListener<CreatePostBloc, CreatePostState>(
              listenWhen: (prev, next) {
                return (prev.isSuccess != next.isSuccess) &&
                    (next.isSuccess == true);
              },
              listener: (context, state) {
                context.pop();
              },
            ),
            BlocListener<CreatePostBloc, CreatePostState>(
              listenWhen: (prev, next) {
                return (next.failure != null);
              },
              listener: (context, state) {
                showToast(state.failure.toString());
              },
            ),
          ],
          child: Scaffold(
              appBar: HelloAppbar(
                title: "글 작성하기",
                action: CommunityActionButton(
                    text: "완료",
                    buttonColor: Color(0xffECF6FE),
                    onTap: () {
                      context.read<CreatePostBloc>().add(SubmitPost());
                    }),
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
              )),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(text: "제목"),
            const SizedBox(height: 13),
            CustomTextFormField(
              hintText: "제목을 입력해주세요",
              onChanged: (value) {
                context.read<CreatePostBloc>().add(TitleChanged(title: value));
              },
              minLines: 1,
              maxLines: 2,
              hintStyle: const TextStyle(
                color: HelloColors.gray,
                fontFamily: HelloFonts.inter,
                fontSize: 12,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
                height: 1.0,
                letterSpacing: 0.12,
                fontFeatures: [
                  FontFeature.enable('dlig'),
                ],
              ),
            ),
            const Divider(),
            const SectionTitle(text: "내용"),
            const SizedBox(height: 13),
            // TextField(
            //   onChanged: (value) {
            //     context.read<CreatePostBloc>().add(BodyChanged(body: value));
            //   },
            //   decoration: const InputDecoration(
            //     hintText: "내용을 입력해주세요",
            //     border: InputBorder.none,
            //   ),
            //   style: const TextStyle(
            //     color: HelloColors.gray,
            //     fontFamily: HelloFonts.inter,
            //     fontSize: 12,
            //     fontStyle: FontStyle.normal,
            //     fontWeight: FontWeight.w500,
            //     height: 1.0,
            //     letterSpacing: 0.12,
            //     fontFeatures: [
            //       FontFeature.enable('dlig'),
            //     ],
            //   ),
            // ),
            CustomTextFormField(
              hintText: "내용을 입력해주세요",
              onChanged: (value) {
                context.read<CreatePostBloc>().add(BodyChanged(body: value));
              },
              minLines: 1,
              maxLines: 10,
              hintStyle: const TextStyle(
                color: HelloColors.gray,
                fontFamily: HelloFonts.inter,
                fontSize: 12,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
                height: 1.0,
                letterSpacing: 0.12,
                fontFeatures: [
                  FontFeature.enable('dlig'),
                ],
              ),
            ),
            const Divider(),
            const SectionTitle(text: "사진 및 영상 업로드"),
            const SizedBox(height: 13),
            BlocBuilder<CreatePostBloc, CreatePostState>(
              builder: (context, state) {
                if (state.medias.isEmpty) {
                  return InkWell(
                    onTap: () {
                      context.read<CreatePostBloc>().add(SelectMedia());
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                      ),
                    ),
                  );
                } else {
                  return InkWell(
                    onTap: () {
                      context.read<CreatePostBloc>().add(SelectMedia());
                    },
                    child: SizedBox(
                      height: 60,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return Image.file(
                            File(state.medias[index].path),
                            width: 60,
                            height: 60,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(width: 4);
                        },
                        itemCount: state.medias.length,
                      ),
                    ),
                  );
                }
              },
            )
          ],
        )),
        const SizedBox(height: 15),
        const Text(
          "사진은 최대 10장까지 업로드 가능합니다.\n영상은 최대 2개까지 업로드 가능합니다.\n과도한 비방 및 욕설이 포함된 게시물은 신고에 의해 무통보 삭제될 수 있습니다.\n초상권, 저작권 침해 및 기타 위법한 게시물은 관리자에 의해 무통보 삭제될 수 있습니다.",
          style: TextStyle(
              color: HelloColors.gray,
              fontFamily: HelloFonts.sbAggroOTF,
              fontSize: 8,
              height: 16 / 8),
        ),
      ],
    );
  }
}
