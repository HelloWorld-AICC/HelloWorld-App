import '../../failure/chat_failure.dart';
import '../../model/chat_message.dart';

abstract class ChatSessionHandler {
  void updateMessages({
    required List<ChatMessage> messages,
    bool isLoading,
    ChatFailure? failure,
  });

  void updateRoomId({required String roomId});

  void setLoading({required bool isLoading, ChatFailure? failure});

  List<ChatMessage> getMessages();
}
