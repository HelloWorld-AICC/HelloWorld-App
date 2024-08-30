import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../model/room/chat_log.dart';
import '../model/room/room.dart';

class RoomService {
  final String _baseUrl = 'http://15.165.84.103:8082';

  // Fetch the list of rooms
  Future<List<Room>> fetchRoomList() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/user/room-list'),
      headers: {'accept': '*/*', 'user_id': '1'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      log("[RoomService-fetchRoomList()] data: $data");

      return data
          .map((item) => Room(
                title: item['title'] as String,
                roomId: item['roomId'] as String,
              ))
          .toList();
    } else {
      throw Exception('Failed to load room list');
    }
  }

  // Fetch recent chat logs for a specific room
  Future<List<ChatLog>> fetchRecentChatLogs(String roomId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/chat/recent-room?roomId=$roomId'),
      headers: {'accept': '*/*', 'user_id': '1'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data
          .map((item) => ChatLog(
                content: item['content'] as String,
                sender: item['sender'] as String,
              ))
          .toList();
    } else {
      throw Exception('Failed to load chat logs');
    }
  }

  // Add a new room
  Future<void> addRoom(Room room) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/user/add-room'),
      headers: {
        'Content-Type': 'application/json',
        'accept': '*/*',
        'user_id': '1',
      },
      body: json.encode({
        'title': room.title,
        'description': 'No description', // Adjust or remove if not needed
      }),
    );

    if (response.statusCode == 200) {
      log("[RoomService-addRoom()] Room added successfully");
    } else {
      log("[RoomService-addRoom()] Failed to add room: ${response.reasonPhrase}");
      throw Exception('Failed to add room');
    }
  }
}
