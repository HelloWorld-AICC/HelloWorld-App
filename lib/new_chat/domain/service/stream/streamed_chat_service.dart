import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:hello_world_mvp/new_chat/application/session/chat_session_bloc.dart';
import 'package:hello_world_mvp/new_chat/domain/service/chat_fetch_service.dart';
import 'package:hello_world_mvp/new_chat/domain/service/stream/streamed_chat_parse_service.dart';
import 'package:injectable/injectable.dart';

import '../../../../fetch/fetch_service.dart';
import '../../../../fetch/network_failure.dart';
import '../../failure/chat_failure.dart';
import '../../model/chat_message.dart';
import '../../model/chat_room.dart';

@injectable
@lazySingleton
class StreamedChatService {
  final ChatFetchService fetchService;
  final StreamedChatParseService parseService;

  StreamedChatService({
    required this.fetchService,
    required this.parseService,
  });

  Future<Either<NetworkFailure, Stream<String>>> sendUserRequest(
      ChatMessage message, String roomId) async {
    final failureOrResponse = await fetchService.streamedRequest(
      method: HttpMethod.post,
      pathPrefix: '/webflux',
      path: '/chat/ask',
      bodyParam: {'content': message.content.getOrCrash().toString()},
      queryParams: {'roomId': roomId},
    );
    print("StreamedChatService :: sendUserRequest : roomId=$roomId");

    failureOrResponse.fold(
      (failure) {
        print("Request failed with failure: $failure");
      },
      (stream) {
        stream.listen(
          (data) {
            print("Streamed data: $data");
          },
          onError: (error) {
            print("Stream error: $error");
          },
          onDone: () {
            parseService.addBotMessage(failureOrResponse);
          },
        );
      },
    );
    return failureOrResponse;
  }

  addChatLogs(Either<ChatFailure, ChatRoom> failureOrChatRoom) {
    failureOrChatRoom.fold(
      (failure) {
        print("Failed to get chat room: $failure");
      },
      (chatRoom) {
        final messages = chatRoom.messages;
        for (final message in messages) {
          print(
              "StreamedChatService :: addChatLogs : message=${message.sender}");
          parseService.addMessage(message);
        }
      },
    );
  }

  clearChatLogs() {
    parseService.clearChatLogs();
  }
}
