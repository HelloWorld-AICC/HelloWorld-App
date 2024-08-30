class ChatLog {
  final String content;
  final String sender;

  ChatLog({
    required this.content,
    required this.sender,
  });

  @override
  String toString() => 'ChatLog(content: $content, sender: $sender)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatLog &&
          runtimeType == other.runtimeType &&
          content == other.content &&
          sender == other.sender);

  @override
  int get hashCode => content.hashCode ^ sender.hashCode;
}
