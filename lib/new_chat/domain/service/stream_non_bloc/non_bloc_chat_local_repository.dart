import '../../model/chat_message.dart';
import '../../model/chat_room.dart';
import 'chat_local_data_source.dart';

class NonBlocChatLocalRepository {
  final ChatLocalDataSource chatLocalDataSource;

  NonBlocChatLocalRepository(this.chatLocalDataSource);

  Future<void> addChat(ChatMessage chat) async {
    return chatLocalDataSource.insertChat(chat);
  }

  Future<void> changeRoomId(String roomId) async {
    return chatLocalDataSource.changeRoomId(roomId);
  }

  Future<List<ChatRoom>> getChats() async {
    return chatLocalDataSource.getChats();
  }
}
