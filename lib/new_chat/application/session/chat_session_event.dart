part of 'chat_session_bloc.dart';

sealed class ChatSessionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class ChangeRoomIdEvent extends ChatSessionEvent {
  final String roomId;

  ChangeRoomIdEvent({required this.roomId});
}

final class LoadChatSessionEvent extends ChatSessionEvent {
  final String? roomId;

  LoadChatSessionEvent({required this.roomId});
}

final class SendMessageEvent extends ChatSessionEvent {
  final String roomId;
  final ChatMessage message;

  SendMessageEvent({this.roomId = "new_chat", required this.message});

  @override
  List<Object> get props => [roomId, message];
}

final class ReceiveMessageEvent extends ChatSessionEvent {
  final ChatMessage message;

  ReceiveMessageEvent({required this.message});

  @override
  List<Object> get props => [message];
}

class ClearMessagesEvent extends ChatSessionEvent {
  ClearMessagesEvent();
}
