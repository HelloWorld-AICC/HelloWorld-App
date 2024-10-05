part of 'chat_session_bloc.dart';

class ChatSessionState extends Equatable {
  final List<ChatLog> messages;
  final bool isLoading;
  final ChatFailure? failure;
  final String? roomId;
  final TypingState typingState;

  const ChatSessionState({
    required this.messages,
    required this.isLoading,
    this.failure,
    this.roomId,
    this.typingState = TypingState.notTyping,
  });

  factory ChatSessionState.initial() => ChatSessionState(
        messages: [],
        isLoading: false,
        roomId: "new-chat",
        typingState: TypingState.notTyping,
      );

  ChatSessionState copyWith({
    List<ChatLog>? messages,
    bool? isLoading,
    ChatFailure? failure,
    String? roomId,
    TypingState? typingState,
  }) {
    return ChatSessionState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
      roomId: roomId ?? this.roomId,
      typingState: typingState ?? this.typingState,
    );
  }

  @override
  List<Object?> get props => [messages, isLoading, failure, roomId];
}
