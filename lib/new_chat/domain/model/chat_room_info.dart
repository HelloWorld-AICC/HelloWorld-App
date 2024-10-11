import '../../../core/value_objects.dart';

class ChatRoomInfo {
  StringVO roomId;
  StringVO title;
  StringVO summary;

  ChatRoomInfo({
    required this.roomId,
    required this.title,
    required this.summary,
  });
}
