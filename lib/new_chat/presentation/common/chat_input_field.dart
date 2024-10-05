import 'package:flutter/material.dart';

class ChatInputField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSend;

  const ChatInputField({
    Key? key,
    required this.controller,
    required this.onSend,
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
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  onSend(value); // Call the send callback
                  controller.clear(); // Clear the input after sending
                }
              },
            ),
          ),
          const SizedBox(width: 8.0),
          // Add spacing between TextField and button
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              final value = controller.text;
              if (value.isNotEmpty) {
                onSend(value); // Call the send callback
                controller.clear(); // Clear the input after sending
              }
            },
          ),
        ],
      ),
    );
  }
}
