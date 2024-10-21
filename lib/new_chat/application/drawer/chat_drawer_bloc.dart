import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/new_chat/infrastructure/repository/chat_rooms_info_repository.dart';
import 'package:injectable/injectable.dart';

import '../../domain/model/chat_room_info.dart';

part 'chat_drawer_event.dart';

part 'chat_drawer_state.dart';

@injectable
class ChatDrawerBloc extends Bloc<ChatDrawerEvent, ChatDrawerState> {
  final ChatRoomsInfoRepository _chatRoomsInfoRepository;

  ChatDrawerBloc(this._chatRoomsInfoRepository)
      : super(ChatDrawerState.initial()) {
    on<OpenDrawerEvent>((event, emit) async {
      final result = await _chatRoomsInfoRepository.getChatRoomsInfo();
      emit(result.fold(
        (failure) {
          return state.copyWith(
            loading: true,
            isDrawerOpen: true,
            chatRoomInfoList: [],
          );
        },
        (chatRooms) {
          return state.copyWith(
            loading: false,
            isDrawerOpen: true,
            chatRoomInfoList: chatRooms,
          );
        },
      ));
    });

    on<CloseDrawerEvent>((event, emit) {
      emit(state.copyWith(isDrawerOpen: false));
    });

    on<StartLoadingEvent>((event, emit) {
      emit(state.copyWith(loading: true));
    });

    on<StopLoadingEvent>((event, emit) {
      emit(state.copyWith(loading: false));
    });
  }
}