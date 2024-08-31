import 'chat_log.dart';

class Room {
  final String title;
  String roomId;
  final List<ChatLog> chatLogs;

  Room({
    required this.title,
    required this.roomId,
    List<ChatLog>? chatLogs,
  }) : chatLogs = chatLogs ?? [];

  // Adds a chat log to the room
  void addChatLog(ChatLog chatLog) {
    chatLogs.add(chatLog);
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'roomId': roomId,
        'chatLogs': chatLogs.map((log) => log.toJson()).toList(),
      };

  @override
  String toString() =>
      'Room(title: $title, roomId: $roomId, chatLogs: $chatLogs)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Room &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          roomId == other.roomId);

  @override
  int get hashCode => title.hashCode ^ roomId.hashCode;
}
