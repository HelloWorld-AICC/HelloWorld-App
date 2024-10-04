import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/value_objects.dart';
import '../../domain/failure/chat_failure.dart';
import '../../domain/model/chat_log.dart';
import '../../domain/service/chat/chat_service.dart';

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
      emit(state.copyWith(isLoading: true));
      final result = await chatService.fetchRecentMessages();
      emit(result.fold(
        (failure) {
          return state.copyWith(
              isLoading: false, messages: [], failure: failure);
        },
        (room) {
          return state.copyWith(
            messages: [...room.chatLogs.getOrCrash(), ...state.messages],
            isLoading: false,
          );
        },
      ));
    });

    on<SendMessageEvent>((event, emit) async {
      final result =
          await chatService.sendMessage(event.message.content.getOrCrash());
      emit(result.fold(
        (failure) {
          return state.copyWith(messages: [], failure: failure);
        },
        (_) {
          return state.copyWith(messages: [...state.messages, event.message]);
        },
      ));
    });

    on<ReceiveMessageEvent>((event, emit) {
      emit(state.copyWith(messages: [...state.messages, event.message]));
    });
  }
}
