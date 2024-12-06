part of 'chat_session_bloc.dart';

class ChatSessionState extends Equatable {
  final String? roomId;
  final List<ChatMessage> messages;
  final bool isLoading;
  final ChatFailure? failure;

  const ChatSessionState({
    required this.roomId,
    required this.messages,
    required this.isLoading,
    this.failure,
  });

  factory ChatSessionState.initial() => ChatSessionState(
        roomId: null,
        messages: [],
        isLoading: true,
        failure: null,
      );

  ChatSessionState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    String? roomId,
    ChatFailure? failure,
  }) {
    return ChatSessionState(
      roomId: roomId ?? this.roomId,
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [roomId, messages, isLoading, failure];
}
