import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/chat/session/chat_session_bloc.dart';

class MessageListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatSessionBloc, ChatSessionState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        final messages = state.messages;

        return ListView.builder(
          controller: ScrollController(),
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            final isUser =
                message.sender.getOrCrash() == 'user'; // Check sender role

            return Column(
              crossAxisAlignment:
                  isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  margin:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  decoration: BoxDecoration(
                    color: isUser
                        ? const Color(0xFFDFEAFF)
                        : const Color(0xFFF4F4F4),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft:
                          isUser ? const Radius.circular(16) : Radius.zero,
                      bottomRight:
                          isUser ? Radius.zero : const Radius.circular(16),
                    ),
                  ),
                  child: Text(
                    message.content.getOrCrash(), // Access content
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
      },
    );
  }
}
