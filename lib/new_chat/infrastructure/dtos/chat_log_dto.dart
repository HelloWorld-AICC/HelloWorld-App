import '../../../core/value_objects.dart';
import '../../domain/model/chat_log.dart';

class ChatLogDto {
  final String content;
  final String sender;

  ChatLogDto({
    required this.content,
    required this.sender,
  });

  factory ChatLogDto.fromJson(Map<String, dynamic> json) {
    return ChatLogDto(
      content: json['content'] as String,
      sender: json['sender'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'sender': sender,
    };
  }

  ChatLog toDomain() {
    return ChatLog(
      content: StringVO(content),
      sender: StringVO(sender),
    );
  }
}
