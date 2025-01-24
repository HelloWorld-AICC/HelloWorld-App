import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/bus/bus.dart';
import 'package:hello_world_mvp/bus/bus_message.dart';
import 'package:hello_world_mvp/community/board/presentation/community_board.dart';
import 'package:hello_world_mvp/community/common/domain/community_failure.dart';
import 'package:hello_world_mvp/community/common/domain/post.dart';
import 'package:hello_world_mvp/community/common/domain/post_list.dart';
import 'package:hello_world_mvp/community/common/domain/repository/i_community_repository.dart';
import 'package:hello_world_mvp/mypage/common/application/mypage_messages.dart';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../common/domain/creat_post.dart';

part 'board_event.dart';

part 'board_state.dart';

@injectable
class BoardBloc extends Bloc<BoardEvent, BoardState> {
  final ICommunityRepository communityRepository;
  final Bus bus;
  late StreamSubscription<BusMessage> busSubscription;

  @override
  Future<void> close() {
    busSubscription.cancel();
    return super.close();
  }

  EventTransformer<T> throttle<T>(Duration duration) {
    return (events, mapper) =>
        events.throttleTime(duration).asyncExpand(mapper);
  }

  BoardBloc({required this.communityRepository, required this.bus})
      : super(BoardState.initial()) {
    busSubscription = bus.subscribe((message) {
      if (message is ProfileUpdatedMessage) {
        add(GetPosts());
      }
    });

    on<Refresh>((event, emit) {
      emit(BoardState.initial().copyWith(selectedBoard: state.selectedBoard));

      add(GetPosts());
    });

    on<GetPosts>((event, emit) async {
      if (state.ended == true) {
        return;
      }

      emit(state.copyWith(isLoading: true));
      final tokenOrFailure = await communityRepository.getPosts(
        categoryId: state.selectedBoard.id,
        page: state.page,
        pageSize: 10,
      );

      emit(tokenOrFailure.fold((f) {
        return state.copyWith(failure: f, isLoading: false);
      }, (myInfo) {
        return state.copyWith(
          postList: [
            if (state.postList != null) ...state.postList!,
            ...myInfo.posts,
          ],
          isLoading: false,
          page: state.page + 1,
          ended: myInfo.posts.isEmpty,
        );
      }));
    }, transformer: throttle(const Duration(milliseconds: 500)));

    on<SelectBoard>((event, emit) {
      emit(state.copyWith(selectedBoard: event.category));
      add(GetPosts());
    });
  }
}
