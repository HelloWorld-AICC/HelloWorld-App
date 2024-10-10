import '../../../core/value_objects.dart';
import '../../domain/model/chat_room_info.dart';

class RoomInfoDTO {
  String roomId;
  String title;

  RoomInfoDTO({
    required this.roomId,
    required this.title,
  });

  factory RoomInfoDTO.fromJson(Map<String, dynamic> json) {
    return RoomInfoDTO(
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
