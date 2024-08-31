import 'dart:developer';

import 'package:flutter/material.dart';

import '../model/room/room.dart';
import '../service/room_service.dart';

class RoomProvider extends ChangeNotifier {
  List<Room> _rooms = [];
  final RoomService _roomService = RoomService();

  List<Room> get rooms => _rooms;

  RoomProvider() {
    _fetchRooms();
    log("[RoomProvider] Initialized");
    log("[RoomProvider] Rooms: $_rooms");
  }

  Future<void> _fetchRooms() async {
    try {
      final roomList = await _roomService.fetchRoomList();
      log("[RoomProvider-fetchRooms()] Rooms: $roomList");
      _rooms = roomList;
      notifyListeners();
    } catch (e) {
      // Handle the error (you can use a logging service or show an error message)
      print('Failed to load rooms: $e');
    }
  }

  void addRoom(String title, String roomId) {
    _rooms.add(Room(title: title, roomId: roomId));
    notifyListeners();
  }
}
