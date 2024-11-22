import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/new_chat/domain/model/chat_message.dart';
import 'package:hello_world_mvp/new_chat/domain/service/stream/streamed_chat_parse_service.dart';
import 'package:hello_world_mvp/new_chat/domain/service/stream/streamed_chat_service.dart';
import 'package:hello_world_mvp/new_chat/infrastructure/repository/chat_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../core/value_objects.dart';
import '../../domain/chat_enums.dart';
import '../../domain/failure/chat_failure.dart';
import '../../domain/service/stream/chat_session_handler.dart';

part 'chat_session_event.dart';

part 'chat_session_state.dart';

@injectable
class ChatSessionBloc extends Bloc<ChatSessionEvent, ChatSessionState>
    implements ChatSessionHandler {
  final ChatRepository chatRepository;
  final StreamedChatService streamedChatService;

  ChatSessionBloc({
    required this.chatRepository,
    required this.streamedChatService,
  }) : super(ChatSessionState.initial()) {
    on<ChangeRoomIdEvent>((event, emit) {
      emit(state.copyWith(roomId: event.roomId));
    });

    on<SendMessageEvent>((event, emit) async {
      final failureOrResponse = await streamedChatService.sendUserRequest(
          event.message, state.roomId ?? 'new_chat');
    });

    on<LoadChatSessionEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      emit(state.copyWith(roomId: event.roomId));
      final roomId = state.roomId;

      if (roomId == 'new_chat' || roomId == null) {
        print("ChatSessionBloc :: LoadChatSessionEvent : roomId is null");
        emit(state.copyWith(isLoading: false));
        return;
      }
      final failureOrChatRoom =
          await chatRepository.getRoomById(StringVO(event.roomId));
      print("ChatSessionBloc :: LoadChatSessionEvent : roomId=$roomId");

      streamedChatService.addChatLogs(failureOrChatRoom);
    });

    on<SetTypingEvent>((event, emit) {
      emit(state.copyWith(
          typingState: event.isTyping
              ? TypingIndicatorState.shown
              : TypingIndicatorState.hidden));
    });

    on<ClearChatSessionEvent>((event, emit) {
      print("ChatSessionBloc :: ClearChatSessionEvent");
      streamedChatService.clearChatLogs();
      emit(state.copyWith(messages: []));
    });

    on<UpdateMessagesEvent>((event, emit) {
      emit(state.copyWith(
        messages: event.messages,
        isLoading: event.isLoading,
        failure: event.failure,
      ));
    });
  }

  @override
  void updateMessages({
    required List<ChatMessage> messages,
    bool isLoading = false,
    ChatFailure? failure,
  }) {
    add(UpdateMessagesEvent(
      messages: messages,
      isLoading: isLoading,
      failure: failure,
    ));
  }

  @override
  void updateRoomId({required String roomId}) {
    add(ChangeRoomIdEvent(roomId: roomId));
  }

  @override
  void setLoading({required bool isLoading, ChatFailure? failure}) {
    add(ChangeLoadingEvent(isLoading: isLoading, failure: failure));
  }

  @override
  List<ChatMessage> getMessages() {
    return state.messages;
  }
}
