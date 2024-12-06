import '../../../core/value_objects.dart';
import '../chat_enums.dart';

class ChatMessage {
  Sender sender;
  StringVO content;

  ChatMessage({
    required this.sender,
    required this.content,
  });

  ChatMessage copyWith({
    Sender? sender,
    StringVO? content,
  }) {
    return ChatMessage(
      sender: sender ?? this.sender,
      content: content ?? this.content,
    );
  }

  @override
  String toString() {
    return 'ChatMessage(sender: $sender, content: $content)';
  }
}
