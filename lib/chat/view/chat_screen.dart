import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world_mvp/route/route_service.dart';

import '../model/chatting_state.dart';
import '../service/gpt_service.dart';
import 'custom_blue_button.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, String>> _messages = [
    {
      'role': 'bot',
      'content':
          '안녕하세요. 챗봇입니다 😀 \n\n도움을 원하시는 경우, 아래 시작 버튼을 누르거나 채팅을 입력해주세요. \n\nAI가 제공하는 정보는 실제와 다를 수 있으니 참고용으로만 사용해주시기 바랍니다.'
    }
  ];

  late AnimationController _animationController;
  late GPTService _gptService;
  ChattingState _chatPageState = ChattingState.initial;
  bool _isTyping = false;

  String _displayText = '';
  String _fullText = '';
  final StreamController<String> _streamController = StreamController<String>();

  List<Map<String, String>> roomList = [];

  @override
  void initState() {
    super.initState();

    _gptService = GPTService(_streamController);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
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

  void _sendMessage() async {
    final message = _controller.text;

    if (message.isEmpty) return;

    _addMessage('user', message);
    _controller.clear();

    _setTyping(true);

    if (message == '시작') {
      _addMessage('bot', '문의 내용을 선택해 주세요. \n\n처음으로 돌아오려면 ' '시작' '을 입력해주세요.');
      _setChattingState(ChattingState.listView);

      _controller.clear();
      _setTyping(false);
      return;
    }

    try {
      await _gptService.sendMessage('66ab9a96f7265b2a2b1b5130', message);

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
      log('[ChatPageState-sendMessage()] Error: Could not fetch response from GPT. $e');
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
      _displayText = ''; // 초기화
    });

    for (int i = 0; i < _fullText.length; i++) {
      await Future.delayed(const Duration(milliseconds: 50));
      setState(() {
        _displayText += _fullText[i];
      });
    }
  }

  List<Widget> _buildActionButtons() {
    final List<String> buttonContents = [
      tr('law'),
      tr('visa'),
      tr('employment'),
      tr('living'),
    ];

    switch (_chatPageState) {
      case ChattingState.initial:
        return [
          CustomBlueButton(
            onPressed: () {
              _addMessage('user', tr('start_button'));
              _addDelayedMessage('bot', tr('choose_question'));
              _setChattingState(ChattingState.listView);
            },
            text: tr('start_button'),
          ),
        ];
      case ChattingState.listView:
        return buttonContents.map((content) {
          return CustomBlueButton(
            onPressed: () {
              _controller.text = content;
              _controller.clear();
              _setTyping(false);
              _setChattingState(ChattingState.detailView);
              _addMessage('user', content);
              _addDelayedMessage(
                'bot',
                tr(
                  'answer_message',
                  namedArgs: {
                    'content': content,
                    'start_button': tr('start_button'),
                  },
                ),
              );
            },
            text: content,
          );
        }).toList();
      case ChattingState.detailView:
        return [
          CustomBlueButton(
            onPressed: () {
              _setChattingState(ChattingState.reponsed);
            },
            text: tr('help_needed'),
          ),
        ];
      case ChattingState.reponsed:
        return [];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    var paddingVal = MediaQuery.of(context).size.height * 0.1;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: Text(
          'Hello World Chatbot',
          style: TextStyle(
            color: const Color(0xff3369FF),
            fontWeight: FontWeight.bold,
            fontSize: 20 * paddingVal / 100,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.summarize, color: Color(0xff3369FF)),
            onPressed: () {
              // TODO: Implement summary feature
            },
          ),
          SizedBox(
            width: 10 * paddingVal / 100,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Room List',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ...roomList.map((room) {
              return ListTile(
                title: Text(room['title'] ?? ''),
                subtitle: Text(room['roomId'] ?? ''),
              );
            }),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: _buildMessageList(),
            ),
            if (_isTyping) _buildTypingIndicator(),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: _buildActionButtons(),
              ),
            ),
            _buildInputArea(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: tr('home'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.chat),
            label: tr('chat'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: tr('profile'),
          ),
        ],
        currentIndex: selectedBottomNavIndex,
        onTap: (int index) {
          selectedBottomNavIndex = index;

          context.go(bottomNavItems[index]);
        },
        selectedItemColor: const Color(0xff3369FF),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white, // 배경색
        elevation: 4.0, // 그림자 깊이
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(
          fontSize: 16.0, // 선택된 아이템의 폰트 크기
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14.0, // 선택되지 않은 아이템의 폰트 크기
        ),
        iconSize: 24.0, // 아이콘 크기
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for (int i = 0; i < 3; i++)
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                double scale = 1.0 +
                    0.3 *
                        (1.0 - (_animationController.value - i / 3).abs())
                            .clamp(0.0, 1.0);
                return Transform.scale(
                  scale: scale,
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: EdgeInsets.only(right: i < 2 ? 6.0 : 0.0),
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];
        final isUser = message['role'] == 'user';
        // log("[ChatPageState-buildMessageList()] isUser: $isUser");

        return Column(
          crossAxisAlignment:
              isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              decoration: BoxDecoration(
                color:
                    isUser ? const Color(0xFFDFEAFF) : const Color(0xFFF4F4F4),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: isUser ? const Radius.circular(16) : Radius.zero,
                  bottomRight: isUser ? Radius.zero : const Radius.circular(16),
                ),
              ),
              child: Text(
                message['content']!,
                style: TextStyle(
                  color: isUser ? const Color(0xFF1777E9) : Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInputArea() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: '메시지 입력',
              ),
              onSubmitted: (value) {
                _sendMessage();
              },
            ),
          ),
        ],
      ),
    );
  }
}
