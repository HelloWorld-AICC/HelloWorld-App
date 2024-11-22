part of 'chat_session_bloc.dart';

class ChatSessionState extends Equatable {
  final String? roomId;
  final List<ChatMessage> messages;
  final Stream<List<ChatMessage>> messagesStream;
  final bool isLoading;
  final TypingIndicatorState typingState;
  final ChatFailure? failure;

  const ChatSessionState({
    required this.roomId,
    required this.messages,
    required this.messagesStream,
    required this.isLoading,
    required this.typingState,
    this.failure,
  });

  factory ChatSessionState.initial() => ChatSessionState(
        roomId: null,
        messages: [],
        messagesStream: Stream.empty(),
        isLoading: true,
        typingState: TypingIndicatorState.hidden,
        failure: null,
      );

  ChatSessionState copyWith({
    List<ChatMessage>? messages,
    Stream<List<ChatMessage>>? messagesStream,
    bool? isLoading,
    String? roomId,
    TypingIndicatorState? typingState,
    ChatFailure? failure,
  }) {
    return ChatSessionState(
      roomId: roomId ?? this.roomId,
      messages: messages ?? this.messages,
      messagesStream: messagesStream ?? this.messagesStream,
      isLoading: isLoading ?? this.isLoading,
      typingState: typingState ?? this.typingState,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props =>
      [roomId, messages, isLoading, typingState, failure];
}
