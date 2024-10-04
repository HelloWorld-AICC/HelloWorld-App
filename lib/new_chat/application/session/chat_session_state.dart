part of 'chat_session_bloc.dart';

class ChatSessionState extends Equatable {
  final List<String> messages;
  final bool isLoading;
  final ChatFailure? failure;
  final String? roomId;

  const ChatSessionState({
    required this.messages,
    required this.isLoading,
    this.failure,
    this.roomId,
  });

  factory ChatSessionState.initial() => const ChatSessionState(
        messages: [],
        isLoading: false,
      );

  ChatSessionState copyWith({
    List<String>? messages,
    bool? isLoading,
    ChatFailure? failure,
    String? roomId,
  }) {
    return ChatSessionState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
      roomId: roomId ?? this.roomId,
    );
  }

  @override
  List<Object?> get props => [messages, isLoading, failure, roomId];
}
