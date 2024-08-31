import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class GPTService {
  final StreamController<String> _controller =
      StreamController<String>.broadcast();

  final String _roomId;

  late final http.Client _httpClient;
  Stream<String> get messages => _controller.stream;

  // roomId는 필수, httpClient는 선택적 매개변수
  GPTService({
    required String roomId,
    http.Client? httpClient,
  })  : _roomId = roomId, // _roomId를 초기화 리스트에서 초기화
        _httpClient =
            httpClient ?? http.Client(); // httpClient가 제공되지 않으면 기본값 사용

  void addMessage(String message) {
    _startListening(
        message, _roomId ?? 'new_chat'); // Pass the message to start listening
  }

  Future<void> _startListening(String message, String roomId) async {
    final url = Uri.parse('http://15.165.84.103:8082/chat/ask?roomId=$roomId');
    final request = http.Request('POST', url)
      ..headers['accept'] = 'text/event-stream'
      ..headers['user_id'] = '1'
      ..headers['Content-Type'] = 'application/json'
      ..body = message;
    log("Requesting to room ID: new_chat");
    log("Request body: ${request.body}");

    final response = await _httpClient.send(request);
    log("Response status code: ${response.statusCode}");
    StringBuffer finalResponse = StringBuffer();

    response.stream.transform(utf8.decoder).listen((data) {
      // _controller.sink.add(data);
      log("Received data: $data");

      if (data.startsWith('data:')) {
        var temp = data.substring(5).trim();
        log("Temp data: $temp");

        // If the data is empty, treat it as a space
        if (temp.isEmpty) {
          temp = ' ';
        }

        // Append non-empty data or space to the StringBuffer
        if (data.startsWith('data:Room ID: ')) {
          _controller.sink.add(data);
          _controller.close();
          log("roomId: $temp");
        } else if (data.startsWith('data:') && temp == 'data:') {
          finalResponse.write('\n');
          log("Appended data: ${finalResponse.toString()}");
        } else {
          finalResponse.write(temp);
          log("Appended data: ${finalResponse.toString()}");

          // Sink the accumulated content to the stream
          _controller.sink.add(finalResponse.toString());
        }
      }
    });
    log("Final response: ${finalResponse.toString()}");
  }

  void dispose() {
    _controller.close();
    _httpClient.close();
  }
}
