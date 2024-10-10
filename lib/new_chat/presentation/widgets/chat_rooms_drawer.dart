import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/drawer/chat_drawer_bloc.dart';
import '../../application/session/chat_session_bloc.dart';

class ChatRoomsDrawer extends StatelessWidget {
  const ChatRoomsDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatDrawerBloc, ChatDrawerState>(
      builder: (context, state) {
        return Drawer(
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
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xff002E4F)),
                    ),
                    subtitle: Text(
                      room.roomId.getOrCrash(),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xff002E4F),
                      ),
                    ),
                    selected: state.selectedRoomId == room.roomId,
                    selectedTileColor: Colors.blue.shade100,
                    onTap: () {
                      context.read<ChatDrawerBloc>().add(
                          SelectRoomEvent(roomId: room.roomId.getOrCrash()));
                    },
                  ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    return DrawerHeader(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Chat Rooms',
            style: const TextStyle(
              color: Color(0xff6D9CD5),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add, color: Color(0xff6D9CD5)),
            onPressed: () {
              context.read<ChatSessionBloc>().add(ClearMessagesEvent());
            },
          ),
        ],
      ),
    );
  }
}
