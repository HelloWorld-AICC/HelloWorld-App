import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:hello_world_mvp/new_chat/domain/dto/chat_log_dto.dart';
import 'package:hello_world_mvp/new_chat/domain/dto/room_dto.dart';
import 'package:http/http.dart' as http;

import 'package:hello_world_mvp/new_chat/domain/chat_repository.dart';
import 'package:hello_world_mvp/new_chat/domain/message.dart';

class IChatRepository implements ChatRepository {
  final List<Message> _messages = [];
  final StreamController<List<Message>> _botMessageStreamController =
      StreamController<List<Message>>.broadcast();

  final http.Client httpClient;

  IChatRepository({http.Client? client}) : httpClient = client ?? http.Client();

  @override
  Future<List<Message>> fetchMessages(
      String baseUrl, String endpoint, String accessToken) async {
    try {
      final response = await httpClient.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: {
          'Accept': '*/*',
          'user_id': accessToken,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        RoomDto roomDto = _parseRoomFromResponse(data);
        _messages.clear();
        _messages.addAll(roomDto.chatLogs
            .map((logDto) => Message(
                  content: logDto.content,
                  sender: logDto.sender,
                ))
            .toList());
        _addStreamedMessages();
        return _messages;
      } else {
        throw Exception('Failed to load messages');
      }
    } catch (e) {
      throw Exception('Failed to load messages: $e');
    }
  }

  Future<List<Message>> getMessages() async {
    return _messages;
  }

  @override
  Future<void> clearMessages() {
    _messages.clear();
    _addStreamedMessages();
    return Future.value();
  }

  @override
  Future<void> sendUserMessage(String baseUrl, String endpoint, String message,
      String accessToken) async {
    final String url = '$baseUrl$endpoint';
    final request = http.Request('POST', Uri.parse(url))
      ..headers['Accept'] = 'text/event-stream'
      ..headers['user_id'] = accessToken
      ..headers['Content-Type'] = 'application/json'
      ..body = json.encode({'message': message});

    try {
      final response = await httpClient.send(request);
      StringBuffer finalResponse = StringBuffer();

      response.stream.transform(utf8.decoder).listen((data) {
        if (data.startsWith('data:')) {
          var temp = data.substring(5).trim();
          if (temp.isEmpty) temp = ' ';

          if (data.startsWith('data:Room ID: ')) {
            _botMessageStreamController.close();
          } else if (data.startsWith('data:') && temp == 'data:') {
            finalResponse.write('\n');
          } else {
            finalResponse.write(temp);
            final botMessage =
                Message(content: finalResponse.toString(), sender: 'bot');

            _messages.add(botMessage);
            _addStreamedMessages();
          }
        }
      }, onError: (error) {
        log("Error receiving stream data: $error");
      }, onDone: () {
        if (!_botMessageStreamController.isClosed) {
          _botMessageStreamController
              .close(); // Ensure the stream is closed when done
        }
      });
    } catch (e) {
      log("Error sending user message: $e");
      rethrow; // Propagate the error
    }
  }

  @override
  Stream<List<Message>> receiveBotMessageStream() {
    return _botMessageStreamController.stream;
  }

  RoomDto _parseRoomFromResponse(Map<String, dynamic> response) {
    final roomId = response['roomId'] as String;
    final chatLogs = (response['chatLogs'] as List<dynamic>)
        .map((log) => ChatLogDTO(
              content: log['content'] as String,
              sender: log['sender'] as String,
            ))
        .toList();

    return RoomDto(
      roomId: roomId,
      chatLogs: chatLogs,
    );
  }

  void _addStreamedMessages() {
    _botMessageStreamController.sink.add(List.from(_messages));
  }

  @override
  addMessage(Message message) {
    _messages.add(message);
    _addStreamedMessages();
  }

  void dispose() {
    _botMessageStreamController.close();
    httpClient.close();
  }
}
