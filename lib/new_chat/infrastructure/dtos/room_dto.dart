import '../../../core/value_objects.dart';
import '../../domain/model/room.dart';
import 'chat_log_dto.dart';

class RoomDto {
  final String roomId;
  final List<ChatLogDto> chatLogs;

  RoomDto({
    required this.roomId,
    required this.chatLogs,
  });

  factory RoomDto.fromJson(Map<String, dynamic> json) {
    return RoomDto(
      roomId: json['roomId'] as String,
      chatLogs: (json['chatLogs'] as List<dynamic>)
          .map((log) => ChatLogDto.fromJson(log))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'chatLogs': chatLogs.map((log) => log.toJson()).toList(),
    };
  }

  Room toDomain() {
    return Room(
      title: StringVO('Recent Room'), // Adjust the title as needed
      roomId: UniqueIdVO.fromUniqueString(roomId),
      chatLogs: ListVO(chatLogs.map((log) => log.toDomain()).toList()),
    );
  }
}
