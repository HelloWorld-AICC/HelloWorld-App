import 'dart:convert';

import 'package:http/http.dart' as http;

class RecentRoomService {
  final String baseUrl;
  final String userId;

  RecentRoomService({required this.baseUrl, required this.userId});

  Future<Map<String, dynamic>> fetchRecentChatRoom() async {
    final response = await http.get(
      Uri.parse('$baseUrl/chat/recent-room'),
      headers: {
        'accept': '*/*',
        'user_id': userId,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load recent chat room');
    }
  }
}
