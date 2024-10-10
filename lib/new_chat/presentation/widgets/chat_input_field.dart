import 'package:flutter/material.dart';

class ChatInputField extends StatelessWidget {
  final TextEditingController controller;
  final Function sendMessage;

  const ChatInputField({
    Key? key,
    required this.controller,
    required this.sendMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
