import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world_mvp/route/route_service.dart';
import 'package:provider/provider.dart';

import '../model/chatting_state.dart';
import '../provider/recent_room_provider.dart';
import '../service/gpt_service.dart';
import '../service/recent_room_service.dart';
import '../service/room_service.dart';
import 'chat_screen.dart';
import 'common/custom_blue_button.dart';
import 'room_drawer.dart';

// ignore: must_be_immutable
class UserCreatedChatScreen extends StatefulWidget {
  late String roomId;
  UserCreatedChatScreen({super.key, this.roomId = 'new_chat'});

  @override
  UserCreatedChatScreenState createState() => UserCreatedChatScreenState();
}

class UserCreatedChatScreenState extends State<UserCreatedChatScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  late AnimationController _animationController;
  late GPTService _gptService;
  late RoomService _roomService;
  late RecentRoomService _recentRoomService;

  final StreamController<String> _messageStreamController =
      StreamController<String>();
  late StreamSubscription<String> _subscription;

  final List<Map<String, String>> _messages = [
    {'role': 'bot', 'content': tr('hello_message')}
  ];

  ChattingState _chatPageState = ChattingState.initial;

  bool _isTyping = false;

  final List<Map<String, String>> roomList = [];

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  void _initializeServices() async {
    _initialize();

    // Initialize services
    _recentRoomService = RecentRoomService(
      baseUrl: 'http://15.165.84.103:8082/chat/recent-room',
      userId: '1',
      recentRoomProvider:
          Provider.of<RecentRoomProvider>(context, listen: false),
    );

    // // Fetch recent chat room and update messages
    // Room room = await _recentRoomService.fetchRecentChatRoom();
    // for (var chatLog in room.chatLogs) {
    //   // 백엔드 응답 에러
    //   _addMessage(chatLog.content, chatLog.sender);
    //   log("[ChatScreenState-initState()] Chat Log: ${chatLog.sender} by ${chatLog.content}");
    // }

    // Initialize GPTService
    _gptService = GPTService(roomId: widget.roomId);

    // Listen to messages stream
    _subscription = _gptService.messages.listen((message) {
      if (message.startsWith('data:Room ID: ')) {
        String extractedMessage = message.substring(5).trim();
        String roomId = extractedMessage.substring(10).trim();
        setState(() {
          widget.roomId = roomId;
        });
        log("[UserCreatedChatScreenState-initState()-listened] Room ID: $roomId");

        if (roomId != widget.roomId) {
          log("[UserCreatedChatScreenState-initState()-listened] Navigating to ChatScreen...");
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ChatScreen(roomId: roomId),
            ),
          );
        }
      } else {
        _messageStreamController.add(message);
      }

      // Scroll to the bottom of the list when a new message is added
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    });

    // Initialize RoomService
    _roomService = RoomService();

    // Initialize RecentRoomProvider and fetch recent chat room
    final recentRoomProvider =
        Provider.of<RecentRoomProvider>(context, listen: false);
    recentRoomProvider.fetchRecentChatRoom(_recentRoomService);
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _animationController.dispose();
    _messageStreamController.close();

    _subscription.cancel(); // 스트림 구독 취소
    super.dispose();
  }

  Future<void> _initialize() async {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    await _fetchRoomList();
  }

  Future<void> _fetchRoomList() async {
    try {
      final rooms = await _roomService.fetchRoomList();
      setState(() {
        roomList.addAll(rooms.map((room) => {
              'roomId': room.roomId,
              'title': room.title,
            }));
      });
    } catch (e) {
      log('Error fetching room list: $e');
    }
  }

  void _setTyping(bool typing) {
    setState(() {
      _isTyping = typing;
    });
  }

  void _addMessage(String role, String content) {
    setState(() {
      _messages.add({'role': role, 'content': content});
    });

    // Scroll to the bottom of the list when a new message is added
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> _addDelayedMessageV2(String role, String content) async {
    _setTyping(true);
    setState(() {
      _messages
          .add({'role': role, 'content': ''}); // Placeholder for typing effect
    });

    StringBuffer displayTextBuffer = StringBuffer();
    for (int i = 0; i < content.length; i++) {
      await Future.delayed(const Duration(milliseconds: 50));
      displayTextBuffer.write(content[i]);
      setState(() {
        _messages.last = {
          'role': role,
          'content': displayTextBuffer.toString(),
        };
      });

      // Scroll to the bottom if needed
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }

    setState(() {
      _isTyping = false;
    });
  }

  List<Widget> _buildActionButtons() {
    final buttonContents = [
      tr('law'),
      tr('visa'),
      tr('employment'),
      tr('living'),
    ];

    switch (_chatPageState) {
      case ChattingState.initial:
        return [
          _buildCustomButton(
            text: tr('start_button'),
            onPressed: () {
              _addMessage('user', tr('start_button'));
              _addDelayedMessageV2('bot', tr('choose_question'));
              _setChattingState(ChattingState.listView);
            },
          ),
        ];
      case ChattingState.listView:
        return buttonContents.map((content) {
          return _buildCustomButton(
            text: content,
            onPressed: () {
              _controller.text = content;
              _controller.clear();
              _setTyping(false);
              _setChattingState(ChattingState.detailView);
              _addMessage('user', content);
              _addDelayedMessageV2(
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
          );
        }).toList();
      case ChattingState.detailView:
        return [
          _buildCustomButton(
            text: tr('help_needed'),
            onPressed: () {
              _setChattingState(ChattingState.reponsed);
            },
          ),
        ];
      case ChattingState.reponsed:
        return [];
      default:
        return [];
    }
  }

  Widget _buildCustomButton(
      {required String text, required VoidCallback onPressed}) {
    return CustomBlueButton(
      onPressed: onPressed,
      text: text,
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(3, (index) {
          return AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              double scale = 1.0 +
                  0.3 *
                      (1.0 - (_animationController.value - index / 3).abs())
                          .clamp(0.0, 1.0);
              return Transform.scale(
                scale: scale,
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: EdgeInsets.only(right: index < 2 ? 6.0 : 0.0),
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder<String>(
      stream: _messageStreamController.stream,
      builder: (context, snapshot) {
        final messages = List<Map<String, String>>.from(_messages);
        if (snapshot.hasData) {
          messages.add({'role': 'bot', 'content': snapshot.data!});
        }

        return ListView.builder(
          controller: _scrollController,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            final isUser = message['role'] == 'user';

            return Column(
              crossAxisAlignment:
                  isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  margin:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  decoration: BoxDecoration(
                    color: isUser
                        ? const Color(0xFFDFEAFF)
                        : const Color(0xFFF4F4F4),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft:
                          isUser ? const Radius.circular(16) : Radius.zero,
                      bottomRight:
                          isUser ? Radius.zero : const Radius.circular(16),
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
              decoration: InputDecoration(
                hintText: tr('inputHint'),
              ),
              onSubmitted: (value) {
                if (value == tr("startButton")) {
                  _setChattingState(ChattingState.initial);
                }

                _addMessage('user', value);
                _gptService.addMessage(value);
                // _messageStreamController.add(value);
                _controller.clear();
                _setTyping(false);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _setChattingState(ChattingState state) {
    setState(() {
      _chatPageState = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    final paddingVal = MediaQuery.of(context).size.height * 0.1;
    final recentRoomProvider = Provider.of<RecentRoomProvider>(context);
    log("[UserCreatedChatScreenState-build()] Building ChatScreen...");

    if (recentRoomProvider.recentChatRoom == null) {
      return const Center(child: CircularProgressIndicator());
    }
    final roomId = widget.roomId;
    final chatLogs = recentRoomProvider.recentChatRoom?.chatLogs ?? [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: Text(
          'Hello World Chatbot',
          style: TextStyle(
            color: const Color(0xff3369FF),
            fontWeight: FontWeight.bold,
            fontSize: 28 * paddingVal / 100,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.summarize,
            ),
            onPressed: () {
              // TODO: Implement summary feature
            },
          ),
          SizedBox(width: 10 * paddingVal / 100),
        ],
      ),
      drawer: RoomDrawer(
        currentRoomId: widget.roomId,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: _buildMessageList()),
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
        onTap: (index) {
          selectedBottomNavIndex = index;
          context.go(bottomNavItems[index]);
        },
        selectedItemColor: const Color(0xff3369FF),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 4.0,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(fontSize: 16.0),
        unselectedLabelStyle: const TextStyle(fontSize: 14.0),
        iconSize: 24.0,
      ),
    );
  }
}
