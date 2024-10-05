part of 'chat_session_bloc.dart';

sealed class ChatSessionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class LoadChatSessionEvent extends ChatSessionEvent {
  final String roomId;

  LoadChatSessionEvent({required this.roomId});

  @override
  List<Object> get props => [roomId];
}

final class SendMessageEvent extends ChatSessionEvent {
  final String roomId;
  final ChatLog message;

  SendMessageEvent({this.roomId = "new-chat", required this.message});

  @override
  List<Object> get props => [roomId, message];
}

final class ReceiveMessageEvent extends ChatSessionEvent {
  final ChatLog message;

  ReceiveMessageEvent({required this.message});

  @override
  List<Object> get props => [message];
}
