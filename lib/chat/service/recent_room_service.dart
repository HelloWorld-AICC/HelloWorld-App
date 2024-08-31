import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../model/room/chat_log.dart';
import '../model/room/room.dart';
import '../provider/recent_room_provider.dart'; // Import the provider

class RecentRoomService {
  final String baseUrl;
  final String userId;
  final RecentRoomProvider recentRoomProvider; // Add reference to the provider

  RecentRoomService({
    required this.baseUrl,
    required this.userId,
    required this.recentRoomProvider,
  });

  // Fetch recent chat room data and notify the provider
  Future<void> fetchRecentChatRoom() async {
    log("[RecentRoomService] Request is being sent to: $baseUrl with user_id: $userId");
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Accept': '*/*',
          'user_id': userId,
        },
      );
      log("[RecentRoomService] Response: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        log("[RecentRoomService] Data: $data");

        // Parse and update the provider with the Room model
        Room room = _parseRoomFromResponse(data);
        recentRoomProvider
            .updateRoom(room); // Update the provider with new data
      } else {
        log('[RecentRoomService-fetchRecentChatRoom] Error fetching recent chat room: ${response.statusCode}');
        throw Exception('Failed to load recent chat room');
      }
    } catch (e) {
      log('[RecentRoomService-fetchRecentChatRoom] Error fetching recent chat room: $e');
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
