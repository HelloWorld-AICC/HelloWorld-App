import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../provider/room_provider.dart';

class RoomDrawer extends StatelessWidget {
  const RoomDrawer({super.key});

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
                  title: Text(room.title),
                  subtitle: Text(room.roomId),
                  onTap: () {
                    context.go('/reopenedChat/room/${room.roomId}');
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
          const Text(
            'Chat Rooms',
            style: TextStyle(
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
    final dummyTitle = 'New Room ${DateTime.now().millisecondsSinceEpoch}';
    final dummyRoomId = 'room_${DateTime.now().millisecondsSinceEpoch}';

    // Call the provider to add the room
    context.read<RoomProvider>().addRoom(dummyTitle, dummyRoomId);

    // Navigate to the new room
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.go('/chat/room/$dummyRoomId');
    });
  }
}
