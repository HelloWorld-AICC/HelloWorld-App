part of 'chat_session_bloc.dart';

class ChatSessionState extends Equatable {
  final String? roomId;
  final List<ChatMessage> messages;
  final bool isLoading;
  final TypingIndicatorState typingState;
  final ChatFailure? failure;

  const ChatSessionState({
    required this.messages,
    required this.isLoading,
    required this.roomId,
    required this.typingState,
    this.failure,
  });

  factory ChatSessionState.initial() => ChatSessionState(
        roomId: "new-chat",
        messages: [],
        isLoading: false,
        typingState: TypingIndicatorState.hidden,
      );

  ChatSessionState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    ChatFailure? failure,
    String? roomId,
    TypingIndicatorState? typingState,
  }) {
    return ChatSessionState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      failure: failure,
      roomId: roomId ?? this.roomId,
      typingState: typingState ?? this.typingState,
    );
  }

  @override
  List<Object?> get props => [messages, isLoading, failure, roomId];
}
