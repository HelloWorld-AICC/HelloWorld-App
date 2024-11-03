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

  ChatSessionBloc({required this.chatRepository})
      : super(ChatSessionState.initial()) {
    // initialize();

    on<LoadChatSessionEvent>((event, emit) async {
      emit(
        state.copyWith(
          isLoading: false,
          typingState: TypingIndicatorState.hidden,
          // messages: Stream.value([
          //   ChatMessage(
          //       sender: Sender.bot,
          //       content: StringVO('Hello! How can I help you?'))
          // ])),
          messageStream: Stream.empty(),
        ),
      );

      // if (event.roomId != 'new_chat') {
      //   final result = await chatRepository.getRoomById(StringVO(event.roomId));
      //   emit(
      //     result.fold(
      //       (failure) => state.copyWith(
      //         isLoading: false,
      //         messages: [],
      //         failure: failure,
      //         typingState: TypingIndicatorState.hidden,
      //       ),
      //       (chatRoom) => state.copyWith(
      //         messages: chatRoom.messages,
      //         isLoading: false,
      //         typingState: TypingIndicatorState.hidden,
      //       ),
      //     ),
      //   );
      // }
    });

    on<SendMessageEvent>((event, emit) async {
      printInColor(
          'Sending message event started: ${event.message.content.getOrCrash()}',
          color: blue);
      List<ChatMessage> currentMessages = [];
      currentMessages = await state.messageStream.first;

      final updatedMessages = [...currentMessages, event.message];
      emit(state.copyWith(
        messageStream: Stream.value(updatedMessages),
        typingState: TypingIndicatorState.shown,
      ));

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
                if (temp.isEmpty) {
                  temp = ' ';
                }
                if (line.startsWith('data:Room ID: ')) {
                  emit(state.copyWith(
                    roomId: temp,
                    typingState: TypingIndicatorState.shown,
                  ));
                } else if (temp == 'data:') {
                  finalResponse.write('\n');
                } else {
                  finalResponse.write(temp);
                }

                final botMessage = ChatMessage(
                  sender: Sender.bot,
                  content: StringVO(finalResponse.toString()),
                );

                final updatedMessages = List<ChatMessage>.from(currentMessages)
                  ..add(botMessage);

                emit(state.copyWith(
                  messageStream: Stream.value(updatedMessages),
                  typingState: TypingIndicatorState.shown,
                ));
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
      final currentMessages = await state.messageStream.first;

      final updatedMessages = [...currentMessages, event.message];
      emit(state.copyWith(
        messageStream: Stream.value(updatedMessages),
        typingState: TypingIndicatorState.hidden,
      ));
    });

    on<ClearMessagesEvent>((event, emit) {
      emit(state.copyWith(
        messageStream: Stream.empty(),
        typingState: TypingIndicatorState.hidden,
      ));
    });
  }
}
