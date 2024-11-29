import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/new_chat/domain/model/chat_message.dart';

import '../../../core/value_objects.dart';
import '../../../design_system/hello_colors.dart';
import '../../../injection.dart';
import '../../application/drawer/chat_drawer_bloc.dart';
import '../../application/session/chat_session_bloc.dart';
import '../../infrastructure/repository/chat_repository.dart';

class ChatRoomsDrawer extends StatefulWidget {
  final StreamController<ChatMessage> streamController;

  const ChatRoomsDrawer({Key? key, required this.streamController})
      : super(key: key);

  @override
  State<ChatRoomsDrawer> createState() => _ChatRoomsDrawerState();
}

class _ChatRoomsDrawerState extends State<ChatRoomsDrawer> {
  @override
  void initState() {
    super.initState();
    // Dispatch OpenDrawerEvent when the widget is first built.
    context.read<ChatDrawerBloc>().add(OpenDrawerEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatDrawerBloc, ChatDrawerState>(
      builder: (context, state) {
        return Drawer(
          backgroundColor: HelloColors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              _buildDrawerHeader(context),
              if (state.loading)
                const Center(child: CircularProgressIndicator())
              else ...[
                for (final room in state.chatRoomInfoList)
                  ListTile(
                    title: Text(
                      room.title.getOrCrash(),
                      style: const TextStyle(
                          fontFamily: "SB AggroOTF",
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: HelloColors.mainColor2),
                    ),
                    subtitle: Text(
                      room.roomId.getOrCrash(),
                      style: const TextStyle(
                        fontFamily: "SB AggroOTF",
                        fontSize: 8,
                        color: HelloColors.mainColor2,
                      ),
                    ),
                    selected: state.selectedRoomId == room.roomId,
                    selectedTileColor: Colors.blue.shade100,
                    onTap: () async {
                      context.read<ChatDrawerBloc>().add(
                          SelectRoomEvent(roomId: room.roomId.getOrCrash()));

                      context.read<ChatSessionBloc>().add(UpdateMessagesEvent(
                          messages: [], isLoading: false, failure: null));

                      final chatRepository = getIt<ChatRepository>();
                      final failureOrChatRoom = await chatRepository
                          .getRoomById(StringVO(room.roomId.getOrCrash()));
                      List<ChatMessage> updatedMessages =
                          failureOrChatRoom.fold(
                        (failure) {
                          return [];
                        },
                        (chatRoom) {
                          List<ChatMessage> fetchedMessages = chatRoom.messages;
                          fetchedMessages = fetchedMessages.map((message) {
                            final content =
                                cleanContent(message.content.getOrCrash());
                            return message.copyWith(content: StringVO(content));
                          }).toList();
                          return fetchedMessages;
                        },
                      );
                      final stateMessages =
                          context.read<ChatSessionBloc>().state.messages;
                      updatedMessages.addAll(stateMessages);

                      updatedMessages.forEach((message) {
                        widget.streamController.add(message);
                      });

                      context.read<ChatSessionBloc>().add(
                            UpdateMessagesEvent(
                              messages: updatedMessages,
                              failure: failureOrChatRoom.fold(
                                (failure) => failure,
                                (chatRoom) => null,
                              ),
                              isLoading: false,
                            ),
                          );
                    },
                  ),
              ],
            ],
          ),
        );
      },
    );
  }

  String cleanContent(String content) {
    final regex = RegExp(r'^\{"content":"(.*)"\}$');

    final match = regex.firstMatch(content);
    if (match != null) {
      return match.group(1)!;
    }
    return content;
  }

  Widget _buildDrawerHeader(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.transparent),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Chatting Room',
            style: const TextStyle(
              fontFamily: 'SB AggroOTF',
              color: HelloColors.subTextColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.add,
              color: HelloColors.subTextColor,
            ),
            onPressed: () {
              context.read<ChatSessionBloc>().add(ClearChatSessionEvent());
            },
          ),
        ],
      ),
    );
  }
}

String formatMessage(String text, int lineLength) {
  final regExp = RegExp('.{1,$lineLength}'); // 1에서 lineLength 길이로 문자열을 나눔
  return regExp.allMatches(text).map((match) => match.group(0)!).join('\n');
}
