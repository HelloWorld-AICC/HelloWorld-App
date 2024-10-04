import '../../../core/value_objects.dart';
import 'chat_log.dart';

class Room {
  final StringVO title;
  final UniqueIdVO roomId;
  final ListVO<ChatLog> chatLogs;

  Room({
    required this.title,
    required this.roomId,
    required this.chatLogs,
  });
}
