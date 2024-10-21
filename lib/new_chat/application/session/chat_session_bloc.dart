import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/fetch/fetch_service.dart';
import 'package:hello_world_mvp/new_chat/domain/model/chat_message.dart';
import 'package:hello_world_mvp/new_chat/domain/service/chat_message_handler.dart';
import 'package:hello_world_mvp/new_chat/infrastructure/repository/chat_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../core/value_objects.dart';
import '../../domain/chat_enums.dart';
import '../../domain/failure/chat_failure.dart';

part 'chat_session_event.dart';

part 'chat_session_state.dart';

@injectable
class ChatSessionBloc extends Bloc<ChatSessionEvent, ChatSessionState> {
  final ChatMessageHandler chatService;
  final ChatRepository chatRepository;

  ChatSessionBloc({required this.chatService, required this.chatRepository})
      : super(ChatSessionState.initial()) {
    chatService.messages.listen((message) {
      add(ReceiveMessageEvent(
          message:
              ChatMessage(sender: Sender.bot, content: StringVO(message))));
    });

    on<LoadChatSessionEvent>((event, emit) async {
      // emit(state.copyWith(isLoading: true, typingState: TypingIndicatorState.hidden));
      final result = await chatRepository.getRoomById(StringVO(state.roomId));
      emit(result.fold(
        (failure) {
          return state.copyWith(
              isLoading: false,
              messages: [],
              failure: failure,
              typingState: TypingIndicatorState.hidden);
        },
        (chatRoom) {
          return state.copyWith(
              messages: [...chatRoom.messages, ...state.messages],
              isLoading: false,
              typingState: TypingIndicatorState.hidden);
        },
      ));
    });

    on<SendMessageEvent>((event, emit) async {
      state.messages.add(event.message);
      emit(state.copyWith(typingState: TypingIndicatorState.shown));
      print("event.message: ${event.message}");
      final result = await chatService.send(
          StringVO(state.roomId), StringVO(event.message.content.getOrCrash()));
      print("result: $result");
      print("event.message: ${event.message}");
      emit(result.fold(
        (failure) {
          return state.copyWith(
              messages: [],
              failure: failure,
              typingState: TypingIndicatorState.hidden);
        },
        (_) {
          return state.copyWith(
              messages: [...state.messages, event.message],
              typingState: TypingIndicatorState.hidden);
        },
      ));
    });

    on<ReceiveMessageEvent>((event, emit) {
      emit(state.copyWith(
          messages: [...state.messages, event.message],
          typingState: TypingIndicatorState.hidden));
    });

    on<ClearMessagesEvent>((event, emit) {
      emit(state.copyWith(
        messages: [],
        typingState: TypingIndicatorState.hidden,
      ));
    });
  }
}
