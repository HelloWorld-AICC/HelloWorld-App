part of 'chat_session_bloc.dart';

sealed class ChatSessionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class LoadChatSessionEvent extends ChatSessionEvent {
  final String? roomId;

  LoadChatSessionEvent({required this.roomId});
}

final class ChangeRoomIdEvent extends ChatSessionEvent {
  final String roomId;

  ChangeRoomIdEvent({required this.roomId});
}

final class UpdateMessagesEvent extends ChatSessionEvent {
  final List<ChatMessage> messages;
  final bool isLoading;
  final ChatFailure? failure;

  UpdateMessagesEvent(
      {required this.messages, required this.isLoading, required this.failure});
}

final class ClearChatSessionEvent extends ChatSessionEvent {}

final class ChangeLoadingEvent extends ChatSessionEvent {
  final bool isLoading;
  final ChatFailure? failure;

  ChangeLoadingEvent({required this.isLoading, required this.failure});
}
