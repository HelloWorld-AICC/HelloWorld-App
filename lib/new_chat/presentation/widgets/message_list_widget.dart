import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/new_chat/application/message/chat_message_bloc.dart';
import 'package:hello_world_mvp/new_chat/application/message/chat_message_event.dart';
import 'package:hello_world_mvp/new_chat/application/message/chat_message_state.dart';
import 'package:hello_world_mvp/new_chat/application/session/chat_session_bloc.dart';
import 'package:hello_world_mvp/new_chat/application/session/chat_session_event.dart';
import 'package:hello_world_mvp/new_chat/application/session/chat_session_state.dart';
import 'package:hello_world_mvp/new_chat/domain/message.dart';

class MessageListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatSessionBloc, ChatSessionState>(
      listener: (context, sessionState) {
        log("Session state: $sessionState");

        if (sessionState is NewSessionState) {
          context
              .read<ChatSessionBloc>()
              .add(const ChatSessionEvent.createNewSession());
          log('New session created');
        } else if (sessionState is PrevSessionState) {
          context
              .read<ChatSessionBloc>()
              .add(const ChatSessionEvent.loadPrevSession());
          log('Previous session loaded');
        }
      },
      child: BlocBuilder<ChatMessageBloc, ChatMessageState>(
        builder: (context, state) {
          return state.when(
            loadSuccess: (messages) {
              log('Messages: $messages');

              return ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return _buildMessageItem(messages[index], context);
                },
              );
            },
            loadInProgress: (m) =>
                const Center(child: CircularProgressIndicator()),
            loadFailure: (m, error) => Center(child: Text('Error: $error')),
            initial: (m) => Container(),
          );
        },
      ),
    );
  }

  Widget _buildMessageItem(Message message, BuildContext context) {
    final isUser = message.sender == 'user';

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
            message.content,
            style: TextStyle(
              color: isUser ? const Color(0xFF1777E9) : Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
