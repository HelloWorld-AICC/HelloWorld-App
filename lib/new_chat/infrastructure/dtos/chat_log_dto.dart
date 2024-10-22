import '../../../core/value_objects.dart';
import '../../domain/chat_enums.dart';
import '../../domain/model/chat_message.dart';

class ChatLogDto {
  final String content;
  final String sender;

  ChatLogDto({
    required this.content,
    required this.sender,
  });

  factory ChatLogDto.fromJson(Map<String, dynamic> json) {
    return ChatLogDto(
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
