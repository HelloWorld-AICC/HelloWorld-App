// lib/screens/chat_screen_reopened.dart
import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/chatting_state.dart';
import '../model/room/chat_log.dart';
import '../service/gpt_service.dart';
import '../service/room_service.dart';
import 'common/common_widgets.dart';

class ChatScreenReopened extends StatefulWidget {
  const ChatScreenReopened({super.key});

  @override
  ChatScreenReopenedState createState() => ChatScreenReopenedState();
}

class ChatScreenReopenedState extends State<ChatScreenReopened>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;

  final StreamController<String> _streamController = StreamController<String>();

  ChattingState _chatPageState = ChattingState.initial;

  late GPTService _gptService;
  late RoomService _roomService;

  bool _isTyping = false;
  String _displayText = '';
  String _fullText = '';

  String? _currentRoomId;

  List<Map<String, String>> roomList = [];
  List<ChatLog> chatLogs = [];
  final List<Map<String, String>> _messages = [];

  @override
  void initState() {
    super.initState();
    _gptService = context.read<GPTService>();
    _roomService = context.read<RoomService>();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
    _fetchRoomList();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _animationController.dispose();
    _streamController.close();
    super.dispose();
  }

  void _setTyping(bool typing) {
    setState(() {
      _isTyping = typing;
    });
  }

  Future<void> _addDelayedMessage(String role, String content) async {
    _setTyping(true);
    await Future.delayed(const Duration(seconds: 1));
    _addMessage(role, content);
    _setTyping(false);
  }

  void _setChattingState(ChattingState state) {
    setState(() {
      _chatPageState = state;
    });
  }

  Future<void> _sendMessage() async {
    final message = _controller.text;

    if (message.isEmpty) return;

    _addMessage('user', message);
    _controller.clear();
    _setTyping(true);

    if (message == '시작') {
      _addMessage('bot', '문의 내용을 선택해 주세요. \n\n처음으로 돌아오려면 시작을 입력해주세요.');
      _setChattingState(ChattingState.listView);
      return;
    }

    try {
      await _gptService.sendMessage(_currentRoomId ?? '', message);

      _streamController.stream.listen((data) async {
        _fullText = data;
        await _startTyping();

        if (_displayText == _fullText) {
          _addMessage('bot', _displayText);
          _setTyping(false);
        }
      });
    } catch (e) {
      _setTyping(false);
      _addMessage('bot', 'Error: Could not fetch response from GPT. $e');
      log('[ChatScreenReopenedState-sendMessage()] Error: Could not fetch response from GPT. $e');
    }
  }

  void _addMessage(String role, String content) {
    setState(() {
      _messages.add({'role': role, 'content': content});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> _startTyping() async {
    setState(() {
      _displayText = '';
    });

    for (int i = 0; i < _fullText.length; i++) {
      await Future.delayed(const Duration(milliseconds: 50));
      setState(() {
        _displayText += _fullText[i];
      });
    }
  }

  Future<void> _fetchRoomList() async {
    try {
      final rooms = await _roomService.fetchRoomList();
      setState(() {
        roomList = rooms
            .map((room) => {
                  'roomId': room.roomId,
                  'title': room.title,
                })
            .toList();
      });
    } catch (e) {
      log('Error fetching room list: $e');
    }
  }

  Future<void> _fetchRecentChatLogs(String roomId) async {
    try {
      chatLogs = await _roomService.fetchRecentChatLogs(roomId);

      final List<Map<String, String>> updatedRoomList =
          chatLogs.map((ChatLog log) {
        return {
          'roomId': roomId, // Adjust if necessary
          'title': log.sender, // Adjust as needed
        };
      }).toList();

      setState(() {
        roomList = updatedRoomList;
      });
    } catch (e) {
      log('Error fetching recent chat logs: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Room'),
      ),
      body: Column(
        children: [
          Expanded(
            child: buildMessageList(_messages, _scrollController),
          ),
          if (_isTyping) buildTypingIndicator(_animationController),
          buildInputArea(_controller, _sendMessage),
        ],
      ),
    );
  }
}
