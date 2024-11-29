import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:hello_world_mvp/new_chat/domain/service/stream/chat_session_handler.dart';
import 'package:injectable/injectable.dart';
import 'package:synchronized/synchronized.dart';

import '../../../../core/value_objects.dart';
import '../../../../fetch/network_failure.dart';
import '../../../../injection.dart';
import '../../../application/session/chat_session_bloc.dart';
import '../../chat_enums.dart';
import '../../failure/chat_failure.dart';
import '../../model/chat_message.dart';
import '../../model/chat_room.dart';

final _lock = Lock();

@injectable
@lazySingleton
class StreamedChatParseService {
  final List<ChatMessage> _messages = [];
  late String _roomId;

  final StreamController<List<ChatMessage>> _messageStreamController =
      StreamController<List<ChatMessage>>.broadcast();

  get messageStream => _messageStreamController.stream;

  Future<void> addMessage(ChatMessage message) async {
    await _lock.synchronized(() async {
      final updatedMessages = List<ChatMessage>.from(_messages)..add(message);
      _messageStreamController.add(updatedMessages);
    });
  }

  Future<void> addMessageToStream(ChatMessage message,
      StreamController<ChatMessage> streamController) async {
    await _lock.synchronized(() async {
      streamController.add(message);
    });
  }

  Future<void> addBotMessage(
      Either<NetworkFailure, Stream<String>> failureOrResponse,
      Function onDone) async {
    await _lock.synchronized(() async {
      ChatMessage? botMessage;

      final streamed_response = failureOrResponse.fold(
        (failure) {
          print("서버에서 응답을 받지 못했습니다: $failure");
        },
        (lineStream) {
          final finalResponse = StringBuffer();

          final subscription = lineStream.listen((line) {
            print('Received line: $line');

            if (line.startsWith('data:')) {
              var temp = line.substring(5).trim();
              print('Processed temp: $temp');

              if (temp.isEmpty) {
                temp = ' ';
                print('Temp was empty, setting to space');
              }

              if (line.startsWith('data:Room ID: ')) {
                print('Room ID found: $temp');
                _roomId = temp;
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

                  final updatedMessages = List<ChatMessage>.from(_messages)
                    ..add(botMessage!);
                  print('Updated messages (new bot message): $updatedMessages');
                  _messageStreamController.add(updatedMessages);
                } else {
                  print('Updating bot message content');
                  final _updatedMessages = List<ChatMessage>.from(_messages);
                  if (_updatedMessages.isNotEmpty) {
                    _updatedMessages.removeLast();
                  }
                  _updatedMessages.add(
                    ChatMessage(
                      sender: Sender.bot,
                      content: StringVO(finalResponse.toString()),
                    ),
                  );
                  print(
                      'Updated messages (modified bot message): $_updatedMessages');
                  _messageStreamController.add(_updatedMessages);
                }
              }
            }
          }, onDone: onDone());

          subscription.cancel();
        },
      );
    });
  }

  Future<void> addChatLogs(
      Either<ChatFailure, ChatRoom> failureOrChatRoom) async {
    await _lock.synchronized(() async {
      final chatSessionBloc = getIt<ChatSessionBloc>();

      failureOrChatRoom.fold(
        (failure) {
          chatSessionBloc
              .add(ChangeLoadingEvent(isLoading: false, failure: failure));
        },
        (chatRoom) {
          final updatedMessages = List<ChatMessage>.from(_messages)
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
        },
      );
    });
  }

  Future<void> clearChatLogs() async {
    await _lock.synchronized(() async {
      _messageStreamController.add([]);
      _messages.clear();
    });
  }
}
