import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/new_chat/domain/service/stream/streamed_chat_parse_service.dart';
import 'package:hello_world_mvp/new_chat/domain/service/stream/streamed_chat_service.dart';
import '../../../injection.dart';
import '../../application/session/chat_session_bloc.dart';
import '../../domain/chat_enums.dart';
import '../../domain/model/chat_message.dart';

class MessageListWidget extends StatefulWidget {
  final Stream<List<ChatMessage>> messageStream;
  final roomId;

  const MessageListWidget({
    Key? key,
    required this.messageStream,
    required this.roomId,
  }) : super(key: key);

  @override
  State<MessageListWidget> createState() => _MessageListWidgetState();
}

class _MessageListWidgetState extends State<MessageListWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ChatMessage>>(
      stream: widget.messageStream,
      builder: (context, snapshot) {
        final messages = snapshot.data ?? [];

        print("New data received: ${messages.length}");

        return ListView.builder(
          controller: ScrollController(),
          itemCount: messages.length,
          itemBuilder: (context, index) {
            return MessageBubble(
              messageStream: Stream.value(
                  StringBuffer(messages[index].content.getOrCrash())),
              isUser: messages[index].sender == Sender.user,
            );
          },
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  final Stream<StringBuffer> messageStream;
  final bool isUser;

  const MessageBubble({
    Key? key,
    required this.messageStream,
    required this.isUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatSessionBloc, ChatSessionState>(
      builder: (context, state) {
        return StreamBuilder<StringBuffer>(
          stream: messageStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            }

            final message = snapshot.data!;

            if (!isUser && state.typingState == TypingIndicatorState.shown) {
              return _buildBubble(context,
                  child: TweenAnimationBuilder<Color?>(
                    tween: ColorTween(
                      begin: Colors.white,
                      end: Colors.black,
                    ),
                    duration: const Duration(seconds: 5),
                    builder: (context, color, child) {
                      return CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            color ?? Colors.white),
                        strokeWidth: 8,
                      );
                    },
                  ));
            }

            return _buildBubble(context,
                child: Text(
                  message.toString(),
                  style: TextStyle(
                    color: isUser ? Colors.white : const Color(0xff002E4F),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ));
          },
        );
      },
    );
  }

  Widget _buildBubble(BuildContext context, {required Widget child}) {
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
          child: child,
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
