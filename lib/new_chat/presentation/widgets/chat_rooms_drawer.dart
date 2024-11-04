import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../design_system/hello_colors.dart';
import '../../application/drawer/chat_drawer_bloc.dart';
import '../../application/session/chat_session_bloc.dart';

class ChatRoomsDrawer extends StatefulWidget {
  const ChatRoomsDrawer({Key? key}) : super(key: key);

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
            'Chatting Room',
            style: const TextStyle(
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
              context.read<ChatSessionBloc>().add(ClearMessagesEvent());
            },
          ),
        ],
      ),
    );
  }
}
