// lib/widgets/common_widgets.dart
import 'package:flutter/material.dart';

Widget buildMessageList(
  List<Map<String, String>> messages,
  ScrollController scrollController,
) {
  return ListView.builder(
    controller: scrollController,
    itemCount: messages.length,
    itemBuilder: (context, index) {
      final message = messages[index];
      final isUser = message['role'] == 'user';

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
            decoration: BoxDecoration(
              color: isUser ? const Color(0xFFDFEAFF) : const Color(0xFFF4F4F4),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: isUser ? const Radius.circular(16) : Radius.zero,
                bottomRight: isUser ? Radius.zero : const Radius.circular(16),
              ),
            ),
            child: Text(
              message['content']!,
              style: TextStyle(
                color: isUser ? const Color(0xFF1777E9) : Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      );
    },
  );
}

Widget buildTypingIndicator(AnimationController animationController) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(3, (index) {
        return AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            double scale = 1.0 +
                0.3 *
                    (1.0 - (animationController.value - index / 3).abs())
                        .clamp(0.0, 1.0);
            return Transform.scale(
              scale: scale,
              child: Container(
                width: 12.0,
                height: 12.0,
                margin: EdgeInsets.only(right: index < 2 ? 6.0 : 0.0),
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
            );
          },
        );
      }),
    ),
  );
}

Widget buildInputArea(TextEditingController controller, Function sendMessage) {
  return Padding(
    padding: const EdgeInsets.all(32.0),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: '메시지 입력',
            ),
            onSubmitted: (value) {
              sendMessage();
            },
          ),
        ),
      ],
    ),
  );
}
