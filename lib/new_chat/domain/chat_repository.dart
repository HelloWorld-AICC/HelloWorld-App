import 'package:hello_world_mvp/new_chat/domain/message.dart';

abstract class ChatRepository {
  Future<List<Message>> fetchMessages(
      String baseUrl, String endpoint, String accessToken);

  Future<List<Message>> getMessages();

  Future<void> clearMessages();

  Future<void> sendUserMessage(
      String baseUrl, String endpoint, String message, String accessToken);

  Stream<List<Message>> receiveBotMessageStream();

  addMessage(Message message);
}
