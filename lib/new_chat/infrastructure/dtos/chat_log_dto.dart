import '../../../core/value_objects.dart';
import '../../domain/chat_enums.dart';
import '../../domain/model/chat_message.dart';

class ChatLogDTO {
  final String content;
  final String sender;

  ChatLogDTO({
    required this.content,
    required this.sender,
  });

  factory ChatLogDTO.fromJson(Map<String, dynamic> json) {
    return ChatLogDTO(
      content: json['content'],
      sender: json['sender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'sender': sender,
    };
  }

  ChatMessage toDomain() {
    return ChatMessage(
      content: StringVO(content),
      sender: sender == 'user' ? Sender.user : Sender.bot,
    );
  }
}
