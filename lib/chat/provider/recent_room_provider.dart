import 'package:flutter/material.dart';

import '../model/room/chat_log.dart';
import '../model/room/room.dart';
import '../service/gpt_service.dart'; // Import GPTService
import '../service/recent_room_service.dart';

class RecentRoomProvider with ChangeNotifier {
  final RecentRoomService _recentRoomService;
  Room? _recentChatRoom;
  GPTService? _gptService;

  RecentRoomProvider(this._recentRoomService);

  Room? get recentChatRoom => _recentChatRoom;

  Future<void> fetchRecentChatRoom() async {
    try {
      // Fetch recent chat room data using the service
      final response = await _recentRoomService.fetchRecentChatRoom();
      _recentChatRoom = _parseRoomFromResponse(response.toJson());
      notifyListeners(); // Notify listeners about the updated data
    } catch (e) {
      // Handle error appropriately
      _recentChatRoom = null;
      notifyListeners(); // Notify listeners about the error state if necessary
      print(
          'Failed to fetch recent chat room: $e'); // Log the error or show a message to the user
    }
  }

  Room _parseRoomFromResponse(Map<String, dynamic> response) {
    String roomId = response['roomId'] as String;
    final chatLogs = (response['chatLogs'] as List<dynamic>)
        .map((log) => ChatLog(
              content: log['content'] as String,
              sender: log['sender'] as String,
            ))
        .toList();

    return Room(
      title: 'Recent Room',
      roomId: roomId,
      chatLogs: chatLogs,
    );
  }

  void initializeGptService(Uri uri) {
    _gptService = GPTService.connect(uri: uri);

    _gptService?.stream.listen((data) {
      if (data.startsWith('roomId: ')) {
        _recentChatRoom?.roomId = data.split('roomId: ').last.trim();
        notifyListeners(); // Notify listeners about the updated roomId
      }
    });
  }
}
