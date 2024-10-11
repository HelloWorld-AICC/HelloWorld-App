import 'package:flutter/material.dart';
import '../../domain/chat_enums.dart';
import '../../domain/model/chat_message.dart';

class MessageListWidget extends StatelessWidget {
  List<ChatMessage> messages = [];

  MessageListWidget({Key? key, required this.messages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: ScrollController(),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return MessageBubble(
          message: messages[index].content.getOrCrash(),
          isUser: messages[index].sender == Sender.user,
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isUser;

  const MessageBubble({
    Key? key,
    required this.message,
    required this.isUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          decoration: _bubbleDecoration(),
          child: Text(
            message,
            style: TextStyle(
              color: isUser ? Colors.white : Color(0xff002E4F),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  BoxDecoration _bubbleDecoration() {
    return BoxDecoration(
      color: isUser ? const Color(0xFF6D9CD5) : const Color(0xFFF4F4F4),
      borderRadius: BorderRadius.only(
        topLeft: const Radius.circular(16),
        topRight: const Radius.circular(16),
        bottomLeft: isUser ? const Radius.circular(16) : Radius.zero,
        bottomRight: isUser ? Radius.zero : const Radius.circular(16),
      ),
    );
  }
}
