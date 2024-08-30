import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class GPTService {
  final StreamController<String> _controller;

  GPTService(this._controller);

  Future<String?> sendMessage(String roomId, String message) async {
    final url = Uri.parse('http://15.165.84.103:8082/chat/ask?roomId=$roomId');
    final headers = {
      'accept': 'text/event-stream',
      'user_id': '1', // Add user_id to headers
      'Content-Type': 'application/json',
    };

    final request = http.Request('POST', url)
      ..headers.addAll(headers)
      ..body = jsonEncode(message); // Send raw JSON string

    log("Requesting to room ID: $roomId");

    try {
      final streamedResponse = await request.send();
      final responseStream = streamedResponse.stream;
      final responseBytes = <int>[];
      final completer = Completer<void>();

      StringBuffer finalResponse =
          StringBuffer(); // Use StringBuffer to concatenate strings efficiently

      responseStream.listen(
        (List<int> chunk) {
          responseBytes.addAll(chunk);
          final responseString = utf8.decode(responseBytes);

          // Process each line starting with "data:"
          final lines = responseString.split('\n');
          for (var line in lines) {
            if (line.startsWith('data:')) {
              var data = line.substring(5).trim();
              // If the data is empty, treat it as a space
              if (data.isEmpty) {
                data = ' ';
              }
              // Append non-empty data or space to the StringBuffer
              if (!data.startsWith('Room ID:')) {
                finalResponse.write(data); // Append data to the StringBuffer
              }
            }
          }

          // Clear the responseBytes after processing
          responseBytes.clear();
        },
        onDone: () {
          log("Final response for room ID $roomId: ${finalResponse.toString()}");
          _controller.add(
              finalResponse.toString()); // Send the final response to the UI
          completer.complete();
        },
        onError: (e) {
          log('Error for room ID $roomId: $e');
          _controller.add('Error occurred: $e');
        },
        cancelOnError: true,
      );

      await completer.future;
    } catch (e) {
      log('Error for room ID $roomId: $e');
      _controller.add('Error occurred: $e');
    }
    return null;
  }
}
