import '../../../core/value_objects.dart';

class ChatLog {
  final StringVO content; // Use StringVO for content
  final StringVO sender; // Use StringVO for sender

  ChatLog({
    required this.content,
    required this.sender,
  });
}
