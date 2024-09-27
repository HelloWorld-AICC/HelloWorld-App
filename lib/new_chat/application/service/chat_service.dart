import 'package:hello_world_mvp/new_chat/domain/chat_repository.dart';
import 'package:hello_world_mvp/new_chat/domain/message.dart';

class ChatService {
  final ChatRepository chatRepository;
  final String baseUrl;
  final String accessToken;

  ChatService({
    required this.chatRepository,
    required this.baseUrl,
    required this.accessToken,
  });

  Future<List<Message>> fetchMessages(String endpoint) async {
    return await chatRepository.fetchMessages(baseUrl, endpoint, accessToken);
  }

  Future<List<Message>> getMessages() async {
    return await chatRepository.getMessages();
  }

  Future<void> sendMessage(String endpoint, String message) async {
    return await chatRepository.sendUserMessage(
        baseUrl, endpoint, message, accessToken);
  }

  Future<void> clearChat() async {
    return await chatRepository.clearMessages();
  }

  Stream<List<Message>> receiveBotMessages() {
    return chatRepository.receiveBotMessageStream();
  }
}
