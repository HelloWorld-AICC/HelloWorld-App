import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/new_chat/domain/model/chat_message.dart';
import 'package:hello_world_mvp/new_chat/infrastructure/repository/chat_repository.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

import '../../../core/value_objects.dart';
import '../../domain/chat_enums.dart';
import '../../domain/failure/chat_failure.dart';
import '../../presentation/widgets/new_chat_content.dart';

part 'chat_session_event.dart';

part 'chat_session_state.dart';

@injectable
class ChatSessionBloc extends Bloc<ChatSessionEvent, ChatSessionState> {
  final ChatRepository chatRepository;
  final StreamController<List<ChatMessage>> _messageStreamController =
      StreamController.broadcast();

  Stream<List<ChatMessage>> get messagesStream =>
      _messageStreamController.stream;

  ChatSessionBloc({required this.chatRepository})
      : super(ChatSessionState.initial()) {
    on<LoadChatSessionEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      try {
        if (event.roomId == 'new_chat') {
          return;
        }
        final failureOrChatRoom =
            await chatRepository.getRoomById(StringVO(event.roomId));

        failureOrChatRoom.fold(
          (failure) {
            emit(state.copyWith(
              isLoading: false,
              failure: failure,
            ));
          },
          (chatRoom) {
            _messageStreamController.add(chatRoom.messages);
            emit(state.copyWith(
              isLoading: false,
              roomId: chatRoom.roomId.getOrCrash(),
            ));
          },
        );
      } catch (error) {
        emit(state.copyWith(
            isLoading: false, failure: ChatFailure(message: error.toString())));
      }
    });

    on<SendMessageEvent>((event, emit) async {
      final updatedMessages = List<ChatMessage>.from(state.messages)
        ..add(event.message);
      _messageStreamController.add(updatedMessages);
      emit(state.copyWith(
          typingState: TypingIndicatorState.shown, messages: updatedMessages));

      final failureOrStream = await chatRepository.sendMessage(
          StringVO(event.roomId), StringVO(event.message.content.toString()));

      await failureOrStream.fold(
        (failure) {
          emit(state.copyWith(
            failure: ChatSendFailure(message: "Failed to send message"),
            typingState: TypingIndicatorState.hidden,
          ));
        },
        (lineStream) async {
          final finalResponse = StringBuffer();

          final subscription = lineStream.listen(
            (line) {
              if (line.startsWith('data:')) {
                var temp = line.substring(5).trim();
                if (temp.isEmpty) temp = ' ';

                if (line.startsWith('data:Room ID: ')) {
                  emit(state.copyWith(
                      roomId: temp, typingState: TypingIndicatorState.shown));
                } else {
                  // Bot 메시지 처리
                  if (temp == 'data:') {
                    finalResponse.write('\n');
                  } else {
                    finalResponse.write(temp);
                  }

                  final botMessage = ChatMessage(
                    sender: Sender.bot,
                    content: StringVO(finalResponse.toString()),
                  );

                  final updatedMessages = List<ChatMessage>.from(state.messages)
                    ..add(botMessage);
                  _messageStreamController.add(updatedMessages);
                  emit(state.copyWith(typingState: TypingIndicatorState.shown));
                }
              }
            },
            onDone: () {
              emit(state.copyWith(typingState: TypingIndicatorState.hidden));
            },
            onError: (error) {
              emit(state.copyWith(
                failure: ChatSendFailure(message: error.toString()),
                typingState: TypingIndicatorState.hidden,
              ));
            },
          );
        },
      );
    });

    on<ReceiveMessageEvent>((event, emit) async {
      final currentMessages = await _messageStreamController.stream.first;

      final updatedMessages = List<ChatMessage>.from(currentMessages)
        ..add(event.message);
      _messageStreamController.add(updatedMessages);
      emit(state.copyWith(typingState: TypingIndicatorState.hidden));
    });

    on<ClearMessagesEvent>((event, emit) {
      _messageStreamController.add([]); // Clear messages
      emit(state.copyWith(typingState: TypingIndicatorState.hidden));
    });
  }

  @override
  Future<void> close() {
    _messageStreamController.close(); // StreamController 닫기
    return super.close();
  }
}
