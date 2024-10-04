import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../fetch/fetch_service.dart';
import '../../failure/chat_failure.dart';
import '../locator/service_locator.dart';

@lazySingleton
class ChatService {
  final StreamController<String> _messageStreamController =
      StreamController<String>.broadcast();
  final _fetchService = ServiceLocator.getFetchService();

  Stream<String> get messageStream => _messageStreamController.stream;

  Future<Either<ChatFailure, List<Message>>> fetchRecentMessages() async {
    final failureOrResponse = await _fetchService.request(
      method: HttpMethod.get,
      pathPrefix: '/chat',
      path: '/recent-room',
    );

    return failureOrResponse.fold(
      (failure) => left(ChatFetchFailure(
          message: 'Failed to load messages: ${failure.message}')),
      (response) => right(response.toJson()),
    );
  }

  Future<Either<ChatFailure, Unit>> sendMessage(String message) async {
    final failureOrResponse = await _fetchService.request(
      method: HttpMethod.post,
      pathPrefix: '/chat',
      path: '/ask',
    );
    return failureOrResponse.fold(
      (failure) => left(ChatSendFailure(
          message: 'Failed to send message: ${failure.message}')),
      (_) => right(unit),
    );
  }

  void startListeningToMessages() {
    Timer.periodic(const Duration(seconds: 1), (_) {
      _messageStreamController
          .add('New message from server: ${DateTime.now()}');
    });
  }
}
