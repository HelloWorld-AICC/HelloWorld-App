part of 'chat_session_bloc.dart';

class ChatSessionState extends Equatable {
  final String? roomId;
  final Stream<List<ChatMessage>> messageStream;
  final bool isLoading;
  final TypingIndicatorState typingState;
  final ChatFailure? failure;

  const ChatSessionState({
    required this.messageStream,
    required this.isLoading,
    required this.roomId,
    required this.typingState,
    this.failure,
  });

  factory ChatSessionState.initial() => ChatSessionState(
        messageStream: Stream.empty(),
        roomId: null,
        isLoading: true,
        typingState: TypingIndicatorState.hidden,
      );

  ChatSessionState copyWith({
    Stream<List<ChatMessage>>? messageStream,
    bool? isLoading,
    ChatFailure? failure,
    String? roomId,
    TypingIndicatorState? typingState,
  }) {
    return ChatSessionState(
      messageStream: messageStream ?? this.messageStream,
      isLoading: isLoading ?? this.isLoading,
      failure: failure,
      roomId: roomId ?? this.roomId,
      typingState: typingState ?? this.typingState,
    );
  }

  @override
  List<Object?> get props => [messageStream, isLoading, failure, roomId];
}
