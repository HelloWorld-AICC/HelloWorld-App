part of 'chat_session_bloc.dart';

class ChatSessionState extends Equatable {
  final String? roomId;
  final List<ChatMessage> messages;
  final bool isLoading;
  final TypingIndicatorState typingState;
  final ChatFailure? failure;

  const ChatSessionState({
    required this.roomId,
    required this.messages,
    required this.isLoading,
    required this.typingState,
    this.failure,
  });

  factory ChatSessionState.initial() => ChatSessionState(
        roomId: null,
        messages: [],
        isLoading: true,
        typingState: TypingIndicatorState.hidden,
        failure: null,
      );

  ChatSessionState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    String? roomId,
    TypingIndicatorState? typingState,
    ChatFailure? failure,
  }) {
    return ChatSessionState(
      roomId: roomId ?? this.roomId,
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      typingState: typingState ?? this.typingState,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props =>
      [roomId, messages, isLoading, typingState, failure];
}
