import '../../../fetch/failure.dart';

class ChatFailure extends Failure {
  const ChatFailure({required super.message});
}

class ChatFetchFailure extends ChatFailure {
  const ChatFetchFailure({required String message}) : super(message: message);
}

class ChatSendFailure extends ChatFailure {
  const ChatSendFailure({required String message}) : super(message: message);
}
