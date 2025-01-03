import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/bus/bus.dart';
import 'package:hello_world_mvp/bus/bus_message.dart';
import 'package:hello_world_mvp/community/board/presentation/community_board.dart';
import 'package:hello_world_mvp/community/common/domain/community_failure.dart';
import 'package:hello_world_mvp/community/common/domain/post_list.dart';
import 'package:hello_world_mvp/community/common/domain/repository/i_community_repository.dart';
import 'package:hello_world_mvp/mypage/common/application/mypage_messages.dart';

import 'package:injectable/injectable.dart';

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

  BoardBloc({required this.communityRepository, required this.bus})
      : super(BoardState.initial()) {
    busSubscription = bus.subscribe((message) {
      if (message is ProfileUpdatedMessage) {
        add(GetPosts());
      }
    });

    on<GetPosts>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final tokenOrFailure = await communityRepository.getPosts(
        categoryId: state.selectedBoard.id,
        page: state.page,
        pageSize: 10,
      );

      emit(tokenOrFailure.fold((f) {
        return state.copyWith(failure: f, isLoading: false);
      }, (myInfo) {
        return state.copyWith(postList: myInfo, isLoading: false);
      }));
    });

    on<SelectBoard>((event, emit) {
      emit(state.copyWith(selectedBoard: event.category));
      add(GetPosts());
    });
  }
}
