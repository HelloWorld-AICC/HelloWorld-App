import 'dart:async';

import 'package:hello_world_mvp/new_chat/domain/model/chat_message.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class StreamedChatService {
  static final StreamedChatService _instance = StreamedChatService._internal();

  factory StreamedChatService() => _instance;

  StreamController<ChatMessage>? _controller;

  StreamController<ChatMessage>? get controller => _controller;

  StreamedChatService._internal() {
    _initializeStream();
  }

  void _initializeStream() {
    _controller = StreamController<ChatMessage>.broadcast();
  }

  Stream<ChatMessage> get stream {
    if (_controller == null || _controller!.isClosed) {
      _initializeStream();
    }
    return _controller!.stream;
  }

  void addMessage(ChatMessage message) {
    if (_controller != null && !_controller!.isClosed) {
      _controller!.sink.add(message);
    }
  }

  void resetStream() {
    _controller?.close();
    _initializeStream();
  }
}
