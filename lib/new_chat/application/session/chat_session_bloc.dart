import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/failure/chat_failure.dart';
import '../../domain/service/chat/chat_service.dart';

part 'chat_session_event.dart';

part 'chat_session_state.dart';

@injectable
class ChatSessionBloc extends Bloc<ChatSessionEvent, ChatSessionState> {
  final ChatService chatService;

  ChatSessionBloc({required this.chatService})
      : super(ChatSessionState.initial()) {
    chatService.messageStream
        .listen((message) => add(ReceiveMessageEvent(message: message)));

    on<LoadChatSessionEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      try {
        final messages = await chatService.fetchRecentMessages();
        emit(state.copyWith(messages: messages, isLoading: false));
      } catch (e) {
        emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      }
    });

    // Handle SendMessageEvent
    on<SendMessageEvent>((event, emit) async {
      try {
        await chatService.sendMessage(event.message);
        emit(state.copyWith(messages: [...state.messages, event.message]));
      } catch (e) {
        emit(state.copyWith(errorMessage: e.toString()));
      }
    });

    // Handle ReceiveMessageEvent
    on<ReceiveMessageEvent>((event, emit) {
      emit(state.copyWith(messages: [...state.messages, event.message]));
    });
  }
}
