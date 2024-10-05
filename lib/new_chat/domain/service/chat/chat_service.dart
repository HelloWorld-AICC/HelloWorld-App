import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../fetch/fetch_service.dart';
import '../../../infrastructure/dtos/chat_log_dto.dart';
import '../../../infrastructure/dtos/room_dto.dart';
import '../../failure/chat_failure.dart';
import '../../model/chat_log.dart';
import '../../model/room.dart';
import '../locator/service_locator.dart';

@lazySingleton
class ChatService {
  final StreamController<String> _messageStreamController =
      StreamController<String>.broadcast();
  final _fetchService = ServiceLocator.getFetchService();

  Stream<String> get messageStream => _messageStreamController.stream;

  Future<Either<ChatFailure, Room>> fetchRecentMessages() async {
    final failureOrResponse = await _fetchService.request(
      method: HttpMethod.get,
      pathPrefix: '/chat',
      path: '/recent-room',
    );

    return failureOrResponse.fold(
      (failure) => left(ChatFetchFailure(
          message: 'Failed to load messages: ${failure.message}')),
      (response) => right(RoomDto.fromJson(response.result).toDomain()),
    );
  }

  Future<Either<ChatFailure, ChatLog>> sendMessage(
      String message, String roomId) async {
    final failureOrResponse = await _fetchService.request(
      method: HttpMethod.post,
      pathPrefix: '/chat',
      path: '/ask',
      bodyParam: {'message': message},
      queryParams: {'roomId': roomId},
    );
    return failureOrResponse.fold(
      (failure) => left(ChatSendFailure(
          message: 'Failed to send message: ${failure.message}')),
      (response) {
        final processedMessage = ChatLogDto.fromJson(response.result);
        return right(processedMessage.toDomain());
      },
    );
  }

  void startListeningToMessages() {
    Timer.periodic(const Duration(seconds: 1), (_) {
      _messageStreamController
          .add('New message from server: ${DateTime.now()}');
    });
  }

  void processData(String data) {
    //   if (data.startsWith('data:')) {
    //     var temp = data.substring(5).trim();
    //     if (temp.isEmpty) =>
    //     temp = '';
    //
    //     if (data.startsWith('data:Room ID: ')) {
    //       _messageStreamController.sink.add(data);
    //       _messageStreamController.close();
    //
    //       final roomId = temp.replaceFirst('data:Room ID: ', '');
    //       roomIdBloc.add(UpdateRoomIdEvent(newRoomId: roomId));
    //     } else {
    //       // 일반 데이터 처리
    //       finalResponse.write(temp);
    //       log("Appended data: ${finalResponse.toString()}");
    //
    //       // 스트림에 누적된 내용 추가
    //       _controller.sink.add(finalResponse.toString());
    //     }
    //   }
  }
}
