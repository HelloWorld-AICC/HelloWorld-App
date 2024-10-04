part of 'room_id_bloc.dart';

class RoomIdState extends Equatable {
  final String roomId;

  const RoomIdState(this.roomId);

  @override
  List<Object?> get props => [roomId];
}
