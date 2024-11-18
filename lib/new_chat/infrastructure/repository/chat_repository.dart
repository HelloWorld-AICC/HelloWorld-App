import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:hello_world_mvp/fetch/authenticated_http_client.dart';
import 'package:hello_world_mvp/new_chat/domain/model/chat_room_info.dart';
import 'package:hello_world_mvp/new_chat/domain/service/chat_fetch_service.dart';
import 'package:hello_world_mvp/new_chat/infrastructure/dtos/chat_log_dto.dart';
import 'package:hello_world_mvp/new_chat/presentation/widgets/new_chat_content.dart';
import 'package:injectable/injectable.dart';

import '../../../core/value_objects.dart';
import '../../../fetch/fetch_service.dart';
import '../../domain/failure/chat_failure.dart';
import '../../domain/model/chat_message.dart';
import '../../domain/model/chat_room.dart';
import '../../domain/repository/i_chat_repository.dart';
import '../dtos/room_dto.dart';

@injectable
@LazySingleton(as: IChatRepository)
class ChatRepository implements IChatRepository {
  final ChatFetchService _fetchService;

  AuthenticatedHttpClient get client => _fetchService.client;

  ChatRepository(this._fetchService);

  @override
  Future<Either<ChatFailure, ChatRoom>> getRoomById(StringVO roomId) async {
    final failureOrResponse = await _fetchService.request(
        method: HttpMethod.get,
        pathPrefix: '/webflux',
        path: '/chat/room-log',
        queryParams: {'roomId': roomId.getOrCrash()});
    return failureOrResponse.fold(
        (failure) => left(
              ChatRoomFetchFailure(
                  message: "Failed to fetch rooms with $roomId"),
            ), (response) {
      final parsedRoomId = response.result['roomId'] as String;
      if (parsedRoomId != roomId.getOrCrash()) {
        return left(ChatRoomIdMismatchFailure(message: "Room ID mismatch"));
      }
      List<RoomDto> chatLogs = response.result['chatLogs'] as List<RoomDto>;
      List<ChatMessage> chatMessages =
          (chatLogs.map((log) => log.toDomain() as ChatMessage)).toList();

      return right(
        ChatRoom(
          roomId: StringVO(parsedRoomId),
          messages: chatMessages,
        ),
      );
    });
  }

  @override
  Future<Either<ChatFailure, List<ChatRoomInfo>>> fetchRoomsInfo() async {
    final failureOrResponse = await _fetchService.request(
      method: HttpMethod.get,
      pathPrefix: '/webflux',
      path: '/user/room-list',
    );
    return failureOrResponse.fold(
        (failure) =>
            left(ChatRoomFetchFailure(message: "Failed to fetch rooms")),
        (response) {
      List<ChatRoomInfo> chatRooms = (response.result as List)
          .map((room) => room.toDomain() as ChatRoomInfo)
          .toList();
      return right(chatRooms);
    });
  }

  Future<Either<ChatFailure, Stream<String>>> sendMessage(
    StringVO roomId,
    StringVO message,
  ) async {
    // final failureOrResponse = await _fetchService.request(
    //   method: HttpMethod.post,
    //   pathPrefix: '/webflux',
    //   path: '/chat/ask',
    //   bodyParam: {'content': message.getOrCrash()},
    //   queryParams: {'roomId': roomId.getOrCrash()},
    // );

    // return failureOrResponse.fold(
    //   (failure) => left(ChatSendFailure(message: "Failed to send message")),
    //   (response) {
    //     printInColor("response: $response", color: red);
    //     printInColor("response result: ${response.result.toString()}",
    //         color: red);
    //     final List<String> chatMessages = response.result['chatLogs']
    //         .map((log) => log['content'] as String)
    //         .toList();
    //
    //     printInColor("chatMessages: $chatMessages", color: red);
    //     return right(chatMessages);
    //   },
    // );

    final failureOrResponse = await _fetchService.streamedRequest(
      method: HttpMethod.post,
      pathPrefix: '/webflux',
      path: '/chat/ask',
      bodyParam: {'content': message.getOrCrash()},
      queryParams: {'roomId': roomId.getOrCrash()},
    );

    return failureOrResponse.fold(
      (failure) => left(ChatSendFailure(message: "Failed to send message")),
      (streamedResponse) {
        final broadcastStream = streamedResponse.asBroadcastStream();
        return right(broadcastStream);
        // final lineStream =
        //     broadcastStream.transform(utf8.decoder).transform(LineSplitter());
        //
        // return right(lineStream);
      },
    );
  }
}
