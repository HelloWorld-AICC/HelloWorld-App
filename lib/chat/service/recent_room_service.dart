import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../model/room/chat_log.dart';
import '../model/room/room.dart';

class RecentRoomService {
  final String baseUrl;
  final String userId;

  RecentRoomService({required this.baseUrl, required this.userId});

  // Fetch recent chat room data and return as a Room instance
  Future<Room> fetchRecentChatRoom() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/chat/recent-room'),
        headers: {
          'Accept': '*/*',
          'user_id': userId,
        },
      );
      log("[RecentRoomService] Request: $baseUrl/chat/recent-room");
      log("[RecentRoomService] Response: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        // Parse and return the Room model
        return _parseRoomFromResponse(data);
      } else {
        throw Exception('Failed to load recent chat room');
      }
    } catch (e) {
      log('Error fetching recent chat room: $e');
      throw Exception('Failed to load recent chat room: $e');
    }
  }

  // Helper method to parse JSON response into a Room model
  Room _parseRoomFromResponse(Map<String, dynamic> response) {
    final roomId = response['roomId'] as String;
    final chatLogs = (response['chatLogs'] as List<dynamic>)
        .map((log) => ChatLog(
              content: log['content'] as String,
              sender: log['sender'] as String,
            ))
        .toList();

    return Room(
      title: 'Recent Room', // Adjust the title as needed
      roomId: roomId,
      chatLogs: chatLogs,
    );
  }
}
