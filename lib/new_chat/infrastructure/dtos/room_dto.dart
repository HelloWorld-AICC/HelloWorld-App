import '../../../core/value_objects.dart';
import '../../domain/model/chat_room.dart';
import 'chat_log_dto.dart';

class RoomDto {
  final String roomId;
  final List<ChatLogDTO> chatLogs;

  RoomDto({
    required this.roomId,
    required this.chatLogs,
  });

  factory RoomDto.fromJson(Map<String, dynamic> json) {
    return RoomDto(
      roomId: json['roomId'],
      chatLogs: (json['chatLogs'] as List)
          .map((e) => ChatLogDTO.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'chatLogs': chatLogs.map((e) => e.toJson()).toList(),
    };
  }

  ChatRoom toDomain() {
    return ChatRoom(
      roomId: StringVO(roomId),
      messages: chatLogs.map((e) => e.toDomain()).toList(),
    );
  }
}
