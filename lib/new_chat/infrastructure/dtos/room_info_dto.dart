import '../../../core/value_objects.dart';
import '../../domain/model/chat_room_info.dart';

class RoomInfoDto {
  String roomId;
  String title;

  RoomInfoDto({
    required this.roomId,
    required this.title,
  });

  factory RoomInfoDto.fromJson(Map<String, dynamic> json) {
    return RoomInfoDto(
      roomId: json['roomId'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'title': title,
    };
  }

  ChatRoomInfo toDomain() {
    return ChatRoomInfo(
      roomId: StringVO(roomId),
      title: StringVO(title),
      summary: StringVO(''),
    );
  }
}
