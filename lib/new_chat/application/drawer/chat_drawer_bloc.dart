import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/new_chat/infrastructure/repository/chat_rooms_info_repository.dart';
import 'package:injectable/injectable.dart';

import '../../domain/model/chat_room_info.dart';
import '../session/chat_session_bloc.dart';

part 'chat_drawer_event.dart';

part 'chat_drawer_state.dart';

@injectable
class ChatDrawerBloc extends Bloc<ChatDrawerEvent, ChatDrawerState> {
  final ChatRoomsInfoRepository _chatRoomsInfoRepository;
  final ChatSessionBloc _chatSessionBloc;

  ChatDrawerBloc(this._chatRoomsInfoRepository, this._chatSessionBloc)
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

    on<SelectRoomEvent>((event, emit) {
      _chatSessionBloc.add(LoadChatSessionEvent(roomId: event.roomId));
      emit(state.copyWith(selectedRoomId: event.roomId));
    });
  }
}
