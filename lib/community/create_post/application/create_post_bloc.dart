import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/auth/domain/failure/auth_failure.dart';
import 'package:hello_world_mvp/auth/domain/repository/i_auth_repository.dart';
import 'package:hello_world_mvp/community/common/domain/creat_post.dart';
import 'package:hello_world_mvp/community/common/domain/repository/i_community_repository.dart';
import 'package:hello_world_mvp/fetch/failure.dart';
import 'package:hello_world_mvp/toast/common_toast.dart';
import 'package:image_picker/image_picker.dart';

import 'package:injectable/injectable.dart';

part 'create_post_event.dart';
part 'create_post_state.dart';

@injectable
class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  final ICommunityRepository communityRepository;

  CreatePostBloc({
    required this.communityRepository,
  }) : super(CreatePostState.initial()) {
    on<TitleChanged>((event, emit) async {
      emit(state.copyWith(title: event.title));
    });
    on<BodyChanged>((event, emit) async {
      emit(state.copyWith(body: event.body));
    });

    on<SelectMedia>((event, emit) async {
      final ImagePicker picker = ImagePicker();
      // Pick an image.
      final List<XFile> medias = await picker.pickMultipleMedia();

      emit(state.copyWith(medias: medias));
    });

    on<SubmitPost>((event, emit) async {
      if (state.title == null || state.title!.isEmpty) {
        showToast("제목을 입력해주세요.");
        return;
      }

      if (state.body == null || state.body!.isEmpty) {
        showToast("내용을 입력해주세요.");
        return;
      }

      emit(state.copyWith(isLoading: true));
      final failureOrSuccess = await communityRepository.createPost(
        categoryId: 0,
        post: CreatePost(
          title: state.title!,
          body: state.body!,
          medias: state.medias.map((e) => File(e.path)).toList(),
        ),
      );
      emit(failureOrSuccess.fold((f) {
        return state.copyWith(isLoading: false, failure: f);
      }, (r) {
        return state.copyWith(isLoading: false, isSuccess: true);
      }));
    });
  }
}
