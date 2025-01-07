import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/community/common/domain/creat_post.dart';
import 'package:hello_world_mvp/community/common/domain/repository/i_community_repository.dart';
import 'package:hello_world_mvp/fetch/failure.dart';
import 'package:hello_world_mvp/toast/common_toast.dart';
import 'package:image_picker/image_picker.dart';

import 'package:injectable/injectable.dart';

import '../../../core/value_objects.dart';
import '../../common/domain/comment.dart';

part 'post_detail_event.dart';

part 'post_detail_state.dart';

@injectable
class PostDetailBloc extends Bloc<PostDetailEvent, PostDetailState> {
  final ICommunityRepository communityRepository;

  PostDetailBloc({
    required this.communityRepository,
  }) : super(PostDetailState.initial()) {
    on<PostDetailFetched>((event, emit) async {
      final failureOrSuccess = await communityRepository.getPostDetail(
          page: 0,
          pageSize: 10,
          categoryId: event.categoryId,
          postId: event.postId);

      failureOrSuccess.fold(
        (failure) {
          emit(state.copyWith(
            isLoading: false,
            failure: failure,
          ));
        },
        (postDetail) {
          emit(state.copyWith(
            isLoading: false,
            title: (postDetail.title.value).getOrElse(() => ""),
            body: postDetail.content.value.getOrElse(() => ""),
            medias: postDetail.fileList.value.getOrElse(() => []).map((fileVO) {
              return XFile(fileVO.getOrCrash());
            }).toList(),
            createdAt: postDetail.createAt.value
                .map((date) => DateTime.parse(date))
                .getOrElse(() => DateTime.now()),
            comments: postDetail.commentList.value.getOrElse(() => []),
            isSuccess: true,
          ));
        },
      );
    });

    on<PostDetailCommentAdded>((event, emit) async {
      final failureOrSuccess = await communityRepository.writeComment(
        categoryId: event.categoryId,
        postId: event.postId,
        content: event.comment,
      );

      failureOrSuccess.fold(
        (failure) {
          emit(state.copyWith(
            isLoading: false,
            failure: failure,
          ));
        },
        (comment) {
          emit(state.copyWith(
            comments: [
              ...state.comments,
              Comment(
                  anonymousName: 0,
                  createdAt: DateVO(DateTime.now()),
                  content: StringVO(event.comment))
            ],
          ));
        },
      );
    });
  }
}
