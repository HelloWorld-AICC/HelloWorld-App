import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/value_objects.dart';
import '../../../domain/failure/chat_failure.dart';
import '../../../domain/model/chat_log.dart';
import '../../../domain/service/chat/chat_service.dart';
import '../typing_state.dart';

part 'chat_session_event.dart';

part 'chat_session_state.dart';

@injectable
class ChatSessionBloc extends Bloc<ChatSessionEvent, ChatSessionState> {
  final ChatService chatService;

  ChatSessionBloc({required this.chatService})
      : super(ChatSessionState.initial()) {
    chatService.messageStream.listen((message) {
      add(ReceiveMessageEvent(
          message:
              ChatLog(content: StringVO(message), sender: StringVO('bot'))));
    });

    on<LoadChatSessionEvent>((event, emit) async {
      log("LoadChatSessionEvent, roomId is ${event.roomId}");
      emit(state.copyWith(isLoading: true, typingState: TypingState.notTyping));
      final result = await chatService.fetchRecentMessages();
      emit(result.fold(
        (failure) {
          return state.copyWith(
              isLoading: false,
              messages: [],
              failure: failure,
              typingState: TypingState.notTyping);
        },
        (room) {
          return state.copyWith(
              messages: [...room.chatLogs.getOrCrash(), ...state.messages],
              isLoading: false,
              typingState: TypingState.notTyping);
        },
      ));
    });

    on<SendMessageEvent>((event, emit) async {
      log("SendMessageEvent, roomId is ${event.roomId}");
      state.messages.add(event.message);
      emit(state.copyWith(
          typingState: TypingState.typing)); // Set typing to true
      log("event.roomId is ${event.roomId}");
      final result = await chatService.sendMessage(
          event.message.content.getOrCrash(), event.roomId);
      emit(result.fold(
        (failure) {
          return state.copyWith(
              messages: [],
              failure: failure,
              typingState:
                  TypingState.notTyping); // Set typing to false on error
        },
        (_) {
          return state.copyWith(
            messages: [...state.messages, event.message],
            typingState:
                TypingState.notTyping, // Set typing to false after sending
          );
        },
      ));
    });

    on<ReceiveMessageEvent>((event, emit) {
      log("ReceiveMessageEvent, roomId is ${event.message}");
      emit(state.copyWith(
          messages: [...state.messages, event.message],
          typingState: TypingState.notTyping));
    });
  }
}
