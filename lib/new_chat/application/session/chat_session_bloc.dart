import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/new_chat/domain/model/chat_message.dart';
import 'package:hello_world_mvp/new_chat/domain/service/streamed_chat_service.dart';
import 'package:hello_world_mvp/new_chat/infrastructure/repository/chat_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';

import '../../../core/value_objects.dart';
import '../../domain/failure/chat_failure.dart';

part 'chat_session_event.dart';

part 'chat_session_state.dart';

@injectable
class ChatSessionBloc extends Bloc<ChatSessionEvent, ChatSessionState> {
  final ChatRepository chatRepository;
  final StreamedChatService streamedChatService;

  ChatSessionBloc({
    required this.chatRepository,
    required this.streamedChatService,
  }) : super(ChatSessionState.initial()) {
    on<LoadChatSessionEvent>((event, emit) async {
      emit(state.copyWith(roomId: event.roomId, isLoading: true));
      final roomId = state.roomId;

      if (roomId == null || roomId == 'new_chat') {
        print("불러올 채팅방 기록이 없습니다.");
        emit(state.copyWith(isLoading: false));
        return;
      }
      final failureOrChatRoom =
          await chatRepository.getRoomById(StringVO(event.roomId));
      List<ChatMessage> updatedMessages = failureOrChatRoom.fold(
        (failure) {
          emit(state.copyWith(
            isLoading: false,
            failure: failure,
          ));
          return [];
        },
        (chatRoom) {
          return chatRoom.messages;
        },
      );
      emit(state.copyWith(
        isLoading: false,
        messages: updatedMessages,
      ));
      // print(formatMessage(
      //     "채팅방 기록을 불러왔습니다: ${updatedMessages.map((e) => e.toString())}", 150));
      updatedMessages.forEach((element) {
        streamedChatService.addMessage(element);
      });
    });

    on<ChangeLoadingEvent>((event, emit) {
      emit(state.copyWith(
        isLoading: event.isLoading,
        failure: event.failure,
      ));
    });

    on<ChangeBlockInputEvent>((event, emit) {
      emit(state.copyWith(blockInput: event.blockInput));
    });

    on<ClearChatSessionEvent>((event, emit) {
      emit(state.copyWith(messages: [], roomId: 'new_chat'));
    });

    on<UpdateMessagesEvent>((event, emit) {
      emit(state.copyWith(
        messages: event.messages,
        failure: event.failure,
      ));
    });

    on<ChangeRoomIdEvent>((event, emit) {
      print("ChatSessionBloc :: ChangeRoomIdEvent : roomId=${event.roomId}");
      streamedChatService.resetStream();
      emit(state.copyWith(roomId: event.roomId));
    });
  }
}
