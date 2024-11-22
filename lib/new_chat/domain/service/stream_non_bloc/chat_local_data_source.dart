import '../../../../core/value_objects.dart';
import '../../model/chat_message.dart';
import '../../model/chat_room.dart';

class ChatLocalDataSource {
  final ChatRoom chatDao;

  ChatLocalDataSource({required this.chatDao});

  insertChat(ChatMessage chat) async {
    chatDao.messages.add(chat);
  }

  changeRoomId(String roomId) async {
    chatDao.roomId = StringVO(roomId);
  }

  getChats() async {
    return chatDao;
  }
}
