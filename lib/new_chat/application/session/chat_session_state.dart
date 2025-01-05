part of 'chat_session_bloc.dart';

class ChatSessionState extends Equatable {
  final String? roomId;
  final List<ChatMessage> messages;
  final bool isLoading;
  final bool blockInput;
  final ChatFailure? failure;

  const ChatSessionState({
    required this.roomId,
    required this.messages,
    required this.isLoading,
    required this.blockInput,
    this.failure,
  });

  factory ChatSessionState.initial() => ChatSessionState(
        roomId: null,
        messages: [],
        isLoading: true,
        blockInput: false,
        failure: null,
      );

  ChatSessionState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    String? roomId,
    bool? blockInput,
    ChatFailure? failure,
  }) {
    return ChatSessionState(
      roomId: roomId ?? this.roomId,
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      blockInput: blockInput ?? this.blockInput,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [roomId, messages, isLoading, blockInput, failure];
}
