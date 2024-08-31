import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart' as html;

class GPTService {
  final StreamController<String> _controller =
      StreamController<String>.broadcast();
  late final html.EventSource _eventSource;
  String? _roomId;

  GPTService._internal(this._eventSource);

  factory GPTService.connect({
    required Uri uri,
    bool withCredentials = false,
    bool closeOnError = true,
  }) {
    final streamController = StreamController<String>.broadcast();
    final eventSource =
        html.EventSource(uri.toString(), withCredentials: withCredentials);

    String? roomId;

    eventSource.addEventListener('message', (html.Event message) {
      final data = (message as html.MessageEvent).data as String;
      if (data.contains('roomId :')) {
        roomId = data.split('roomId :').last.trim();
        streamController.add('roomId: $roomId'); // Inform about roomId
        eventSource.close();
        streamController.close();
      } else {
        streamController.add(data);
      }
    });

    if (closeOnError) {
      eventSource.onError.listen((event) {
        eventSource.close();
        streamController.close();
      });
    }

    final gptService = GPTService._internal(eventSource);
    gptService._controller.addStream(streamController.stream);

    return gptService;
  }

  Stream<String> get stream => _controller.stream;

  String? get roomId => _roomId;

  bool isClosed() => _controller.isClosed;

  void close() {
    _eventSource.close();
    _controller.close();
  }

  Future<void> sendMessage(String roomId, String message) async {
    final url = Uri.parse('http://15.165.84.103:8082/chat/ask?roomId=$roomId');
    final headers = {
      'Accept': 'text/event-stream',
      'user_id': '1',
      'Content-Type': 'application/json',
    };

    log("Requesting to room ID: $roomId");

    try {
      final request = http.Request('POST', url)
        ..headers.addAll(headers)
        ..body = jsonEncode({'message': message});

      await request.send(); // Send the request
    } catch (e) {
      log('Error for room ID $roomId: $e');
      _controller.add('Error occurred: $e');
    }
  }
}
