import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/session/chat_session_bloc.dart';
import '../../domain/chat_enums.dart';
import '../../domain/model/chat_message.dart';

class MessageWidget extends StatelessWidget {
  final List<ChatMessage> messages;
  final String? roomId;
  final bool isUser;

  const MessageWidget({
    Key? key,
    required this.messages,
    required this.roomId,
    required this.isUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        if (!isUser && context.read<ChatSessionBloc>().state.isLoading) {
          return TweenAnimationBuilder<Color?>(
            tween: ColorTween(
              begin: Colors.white,
              end: Colors.black,
            ),
            duration: const Duration(seconds: 5),
            builder: (context, color, child) {
              return CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(color ?? Colors.white),
                strokeWidth: 8,
              );
            },
          );
        }

        return ListTile(
          title: Text(
            messages[index].content.getOrCrash(),
            style: TextStyle(
              color: isUser ? Colors.white : const Color(0xff002E4F),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      },
    );
  }
}
