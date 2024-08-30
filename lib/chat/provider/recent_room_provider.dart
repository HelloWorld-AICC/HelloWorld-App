import 'package:flutter/material.dart';

import '../service/recent_room_service.dart';

class RecentRoomProvider with ChangeNotifier {
  final RecentRoomService _recentRoomService;
  Map<String, dynamic>? _recentChatRoom;

  RecentRoomProvider(this._recentRoomService);

  Map<String, dynamic>? get recentChatRoom => _recentChatRoom;

  Future<void> fetchRecentChatRoom() async {
    try {
      _recentChatRoom = await _recentRoomService.fetchRecentChatRoom();
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }
}
