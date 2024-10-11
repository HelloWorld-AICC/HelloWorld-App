import '../../../core/value_objects.dart';
import 'chat_message.dart';

class ChatRoom {
  StringVO roomId;
  List<ChatMessage> messages;

  ChatRoom({required this.roomId, required this.messages});
}
