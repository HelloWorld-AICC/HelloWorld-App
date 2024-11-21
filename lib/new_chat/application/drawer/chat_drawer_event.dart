part of 'chat_drawer_bloc.dart';

abstract class ChatDrawerEvent extends Equatable {
  const ChatDrawerEvent();

  @override
  List<Object?> get props => [];
}

class StartLoadingEvent extends ChatDrawerEvent {
  const StartLoadingEvent();
}

class StopLoadingEvent extends ChatDrawerEvent {
  const StopLoadingEvent();
}

class OpenDrawerEvent extends ChatDrawerEvent {
  const OpenDrawerEvent();
}

class CloseDrawerEvent extends ChatDrawerEvent {
  const CloseDrawerEvent();
}

class SelectRoomEvent extends ChatDrawerEvent {
  final String roomId;

  const SelectRoomEvent({required this.roomId});

  @override
  List<Object?> get props => [roomId];
}
