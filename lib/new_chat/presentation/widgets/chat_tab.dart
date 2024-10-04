import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/core/value_objects.dart';

import '../../application/chat/roomId/room_id_bloc.dart';
import '../../application/chat/session/chat_session_bloc.dart';
import '../../domain/model/chat_log.dart';

class ChatTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<ChatSessionBloc, ChatSessionState>(
            builder: (context, chatState) {
              return ListView.builder(
                itemCount: chatState.messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(chatState.messages[index].content.getOrCrash()),
                  );
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: TextEditingController(),
                  onSubmitted: (message) {
                    if (message.isNotEmpty) {
                      final roomId = context.read<RoomIdBloc>().state.roomId;
                      context.read<ChatSessionBloc>().add(SendMessageEvent(
                          message: ChatLog(
                              content: StringVO(message),
                              sender: StringVO('user')),
                          roomId: roomId));
                    }
                  },
                  decoration: InputDecoration(labelText: '메시지 입력'),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  final roomId = context.read<RoomIdBloc>().state.roomId;
                  final message = '유저 메시지'; // 실제로는 TextField에서 받아야 함
                  context.read<ChatSessionBloc>().add(SendMessageEvent(
                        message: ChatLog(
                            content: StringVO(message),
                            sender: StringVO('user')),
                        roomId: roomId,
                      ));
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
