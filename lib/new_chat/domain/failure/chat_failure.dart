import '../../../fetch/failure.dart';

class ChatFailure extends Failure {
  const ChatFailure({required super.message});
}

class ChatSendFailure extends ChatFailure {
  const ChatSendFailure({required super.message});
}

class ChatRoomFetchFailure extends ChatFailure {
  const ChatRoomFetchFailure({required super.message});
}

class ChatRoomsInfoFetchFailure extends ChatFailure {
  const ChatRoomsInfoFetchFailure({required super.message});
}

class ChatRoomIdMismatchFailure extends ChatFailure {
  const ChatRoomIdMismatchFailure({required super.message});
}
