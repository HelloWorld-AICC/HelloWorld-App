import '../chat_enums.dart';
import 'chat_room.dart';
import 'chat_room_info.dart';

class ChatSession {
  ChatPageSessionState sessionState;
  TypingIndicatorState typingState;
  ChatRoomInfo allocatedRoomInfo;
  ChatRoom allocatedRoom;

  ChatSession({
    required this.sessionState,
    required this.typingState,
    required this.allocatedRoomInfo,
    required this.allocatedRoom,
  });
}
