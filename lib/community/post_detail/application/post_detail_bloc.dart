import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/community/common/domain/creat_post.dart';
import 'package:hello_world_mvp/community/common/domain/repository/i_community_repository.dart';
import 'package:hello_world_mvp/fetch/failure.dart';
import 'package:hello_world_mvp/toast/common_toast.dart';
import 'package:image_picker/image_picker.dart';

import 'package:injectable/injectable.dart';

part 'post_detail_event.dart';
part 'post_detail_state.dart';

@injectable
class PostDetailBloc extends Bloc<PostDetailEvent, PostDetailState> {
  final ICommunityRepository communityRepository;

  PostDetailBloc({
    required this.communityRepository,
  }) : super(PostDetailState.initial()) {
    on<PostDetailFetched>((event, emit) async {
      // emit(state.copyWith(title: event.title));
    });
  }
}
