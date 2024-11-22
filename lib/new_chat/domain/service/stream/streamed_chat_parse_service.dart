import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:hello_world_mvp/new_chat/domain/service/stream/chat_session_handler.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/value_objects.dart';
import '../../../../fetch/network_failure.dart';
import '../../../../injection.dart';
import '../../../application/session/chat_session_bloc.dart';
import '../../chat_enums.dart';
import '../../failure/chat_failure.dart';
import '../../model/chat_message.dart';
import '../../model/chat_room.dart';

final List<ChatMessage> tempMessages = [];

@injectable
class StreamedChatParseService {
  // final ChatSessionBloc chatSessionBloc;
  // final ChatSessionHandler chatSessionHandler;
  final StreamController<List<ChatMessage>> _messageStreamController =
      StreamController<List<ChatMessage>>.broadcast();

  Stream<List<ChatMessage>> get messageStream =>
      _messageStreamController.stream;

  addMessage(ChatMessage message) {
    print("Current messages: ${tempMessages.map((e) => e.sender)}");
    final updatedMessages = tempMessages..add(message);
    _messageStreamController.add(updatedMessages);
  }

  addBotMessage(
      Either<NetworkFailure, Stream<String>> failureOrResponse) async {
    final chatSessionBloc = getIt<ChatSessionBloc>();
    ChatMessage? botMessage;

    final streamed_response = failureOrResponse.fold(
      (failure) {
        chatSessionBloc.add(
          ChangeLoadingEvent(
            isLoading: false,
            failure: null,
          ),
        );
      },
      (lineStream) {
        final finalResponse = StringBuffer();

        final subscription = lineStream
            // .transform(Utf8Decoder())
            // .transform(LineSplitter())
            .listen((line) {
          print('Received line: $line'); // 라인 수신 로그

          if (line.startsWith('data:')) {
            var temp = line.substring(5).trim();
            print('Processed temp: $temp'); // temp 값 로그

            if (temp.isEmpty) {
              temp = ' ';
              print('Temp was empty, setting to space');
            }

            if (line.startsWith('data:Room ID: ')) {
              print('Room ID found: $temp');
              chatSessionBloc.add(
                ChangeRoomIdEvent(roomId: temp),
              );
            } else {
              if (temp == 'data:') {
                print('Data is empty, appending newline');
                finalResponse.write('\n');
              } else {
                print('Appending content: $temp');
                finalResponse.write(temp);
              }

              if (botMessage == null) {
                print('Creating new bot message');
                botMessage = ChatMessage(
                  sender: Sender.bot,
                  content: StringVO(finalResponse.toString()),
                );

                final updatedMessages = tempMessages..add(botMessage!);
                print('Updated messages (new bot message): $updatedMessages');
                _messageStreamController.add(updatedMessages);
              } else {
                print('Updating bot message content');
                final updatedMessages = [
                  ...tempMessages.sublist(0, -1),
                  botMessage!.copyWith(
                    content: StringVO(finalResponse.toString()),
                  )
                ];
                print(
                    'Updated messages (modified bot message): $updatedMessages');
                _messageStreamController.add(updatedMessages);

                chatSessionBloc.add(
                  UpdateMessagesEvent(
                    messages: updatedMessages,
                    isLoading: false,
                    failure: null,
                  ),
                );
              }
            }
          }
        }, onDone: () {
          print('Stream processing done');
          chatSessionBloc.add(
            ChangeLoadingEvent(
              isLoading: false,
              failure: null,
            ),
          );
        });

        subscription.cancel();
      },
    );
  }

  addChatLogs(Either<ChatFailure, ChatRoom> failureOrChatRoom) {
    final chatSessionBloc = getIt<ChatSessionBloc>();

    failureOrChatRoom.fold(
      (failure) {
        chatSessionBloc
            .add(ChangeLoadingEvent(isLoading: false, failure: failure));
        // chatSessionHandler.setLoading(isLoading: false, failure: failure);
      },
      (chatRoom) {
        // _messageStreamController.add(chatRoom.messages);
        // final updatedMessages =
        //     List<ChatMessage>.from(chatSessionBloc.state.messages)
        //       ..addAll(chatRoom.messages);
        // chatSessionBloc.add(UpdateMessagesEvent(
        //     messages: updatedMessages, isLoading: false, failure: null));
        // final updatedMessages = [
        //   ...chatSessionHandler.getMessages(),
        //   ...chatRoom.messages
        // ];
        final updatedMessages = List<ChatMessage>.from(tempMessages)
          ..addAll(chatRoom.messages);
        _messageStreamController.add(updatedMessages);
        print('Updated messages: ${updatedMessages.map((e) => e.content)}');

        chatSessionBloc.add(
          UpdateMessagesEvent(
            messages: updatedMessages,
            isLoading: false,
            failure: null,
          ),
        );

        // chatSessionHandler.updateMessages(
        //   messages: updatedMessages,
        //   isLoading: false,
        //   failure: null,
        // );
      },
    );
  }

  clearChatLogs() {
    _messageStreamController.add([]);
    // chatSessionHandler.updateMessages(messages: []);
    tempMessages.clear();
  }
}
