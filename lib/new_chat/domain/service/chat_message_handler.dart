import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/value_objects.dart';
import '../../infrastructure/repository/chat_repository.dart';
import '../failure/chat_failure.dart';

@injectable
class ChatMessageHandler {
  final ChatRepository _chatRepository;
  final StreamController<String> _messageStreamController =
      StreamController<String>.broadcast();

  Stream<String> get messages => _messageStreamController.stream;

  ChatMessageHandler(this._chatRepository);

  Future<Either<ChatFailure, Unit>> send(
      StringVO roomId, StringVO message) async {
    final failureOrResponse =
        await _chatRepository.sendMessage(roomId, message);
    return failureOrResponse.fold(
        (failure) => left(ChatSendFailure(message: "Failed to send message")),
        (response) {
      print("response: $response");
      _messageStreamController.sink.add(message.getOrCrash());
      return right(unit);
    });
  }
}
