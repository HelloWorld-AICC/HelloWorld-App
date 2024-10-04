// import 'dart:developer';
//
// import 'package:flutter/material.dart';
//
// import '../model/room/room.dart';
// import '../service/recent_room_service.dart';
//
// class RecentRoomProvider with ChangeNotifier {
//   Room? _recentChatRoom;
//
//   Room? get recentChatRoom => _recentChatRoom;
//
//   // This method updates the room and notifies listeners
//   void updateRoom(Room room) {
//     _recentChatRoom = room;
//     notifyListeners(); // Notify listeners about the updated data
//   }
//
//   // Optional: You can still provide a method to fetch directly from the provider if needed
//   void fetchRecentChatRoom(RecentRoomService service) async {
//     try {
//       await service.fetchRecentChatRoom();
//     } catch (e) {
//       _recentChatRoom = null;
//       notifyListeners();
//       log('Failed to fetch recent chat room: $e');
//     }
//   }
// }
