part of 'room_id_bloc.dart';

sealed class RoomIdEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class UpdateRoomIdEvent extends RoomIdEvent {
  final String newRoomId;

  UpdateRoomIdEvent({required this.newRoomId});

  @override
  List<Object?> get props => [newRoomId];
}
