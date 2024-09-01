import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hello_world_mvp/chat/view/user_created_chat_screen.dart';
import 'package:provider/provider.dart';

import '../provider/room_provider.dart';
import 'chat_screen.dart';

class RoomDrawer extends StatefulWidget {
  final String currentRoomId;

  const RoomDrawer({super.key, required this.currentRoomId});

  @override
  _RoomDrawerState createState() => _RoomDrawerState();
}

class _RoomDrawerState extends State<RoomDrawer> {
  late String selectedRoomId;

  @override
  void initState() {
    super.initState();
    // 초기 selectedRoomId를 현재 roomId로 설정
    selectedRoomId = widget.currentRoomId;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Consumer<RoomProvider>(
        builder: (context, roomProvider, child) {
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              _buildDrawerHeader(context),
              ...roomProvider.rooms.map((room) {
                return ListTile(
                  title: Text(
                    room.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    room.roomId,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  selected: selectedRoomId == room.roomId,
                  selectedTileColor: Colors.blue.shade100, // 선택된 항목의 배경색
                  onTap: () {
                    setState(() {
                      selectedRoomId = room.roomId; // 선택된 roomId 업데이트
                    });
                    log("[RoomDrawer] Navigating to ChatScreen with roomId: ${room.roomId}");
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(roomId: room.roomId),
                      ),
                    );
                  },
                );
              }),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(
        color: Color(0xff3369FF),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            tr('chatRooms'),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () => _addRoomAndNavigate(context),
          ),
        ],
      ),
    );
  }

  void _addRoomAndNavigate(BuildContext context) {
    final dummyRoomId = 'room_${DateTime.now().millisecondsSinceEpoch}';
    final dummyTitle = 'Not Yet Named Room_$dummyRoomId';

    // Call the provider to add the room
    context.read<RoomProvider>().addRoom(dummyTitle, dummyRoomId);

    // Close the current screen and navigate to the new screen
    Navigator.of(context)
        .popUntil((route) => route.isFirst); // Pop to the root if necessary

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              UserCreatedChatScreen(roomId: 'user_created_room_$dummyRoomId'),
        ),
      );
    });
  }
}
