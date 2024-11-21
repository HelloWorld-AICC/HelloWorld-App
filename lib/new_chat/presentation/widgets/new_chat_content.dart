import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/value_objects.dart';
import '../../../custom_bottom_navigationbar.dart';
import '../../../design_system/hello_colors.dart';
import '../../application/drawer/chat_drawer_bloc.dart';
import '../../application/session/chat_session_bloc.dart';
import '../../domain/chat_enums.dart';
import '../../domain/model/chat_message.dart';
import 'chat_guide_widget.dart';
import 'chat_input_field.dart';
import 'chat_rooms_drawer.dart';
import 'message_list_widget.dart';

class NewChatContent extends StatefulWidget {
  @override
  NewChatContentState createState() => NewChatContentState();
}

class NewChatContentState extends State<NewChatContent>
    with WidgetsBindingObserver {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final chatSessionBloc = context.read<ChatSessionBloc>();
      if (chatSessionBloc.state.roomId == null &&
          chatSessionBloc.state.isLoading) {
        print('NewChatContent :: initState : LoadChatSessionEvent');
        chatSessionBloc.add(
          LoadChatSessionEvent(roomId: 'new_chat'),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatSessionBloc, ChatSessionState>(
      builder: (context, state) {
        print("NewChatContent :: messagesStream : ${state.messagesStream}");
        return SafeArea(
          child: Scaffold(
            key: _scaffoldKey,
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            appBar: _buildAppBar(state),
            body: _buildBody(state),
            bottomNavigationBar: Visibility(
              visible: !isKeyboardVisible,
              child: CustomBottomNavigationBar(items: bottomNavItems),
            ),
            drawer: ChatRoomsDrawer(),
            onDrawerChanged: (isOpen) {
              if (!isOpen) {
                final selectedRoomId =
                    context.read<ChatDrawerBloc>().state.selectedRoomId;
                context
                    .read<ChatDrawerBloc>()
                    .add(CloseDrawerEvent(selectedRoomId: selectedRoomId));
                context
                    .read<ChatSessionBloc>()
                    .add(ChangeRoomIdEvent(roomId: selectedRoomId));
              }
            },
          ),
        );
      },
    );
  }

  AppBar _buildAppBar(ChatSessionState state) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        tr('chat_title'),
        style: TextStyle(
          color: HelloColors.subTextColor,
          fontFamily: "SB AggroOTF",
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.list_rounded,
          color: HelloColors.subTextColor,
        ),
        onPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.add,
            color: HelloColors.subTextColor,
          ),
          onPressed: () {
            context.read<ChatSessionBloc>().add(ClearMessagesEvent());
          },
        ),
      ],
    );
  }

  Widget _buildBody(ChatSessionState state) {
    if (state.roomId == null || state.roomId == 'new_chat') {
      return Padding(
        padding: const EdgeInsets.only(
          top: 10,
          left: 10,
          right: 100,
          bottom: 350,
        ),
        child: ChatGuideWidget(),
      );
    } else {
      print("NewChatContent :: roomId : ${state.roomId}");
      print("NewChatContent :: messages : ${state.messages}");
      print("NewChatContent :: messagesStream : ${state.messagesStream}");
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: MessageListWidget(
                messageStream: state.messagesStream,
              ),
            ),
            _buildInputArea(state.roomId),
          ],
        ),
      );
    }
  }

  Widget _buildInputArea(String? roomId) {
    return ChatInputField(
      sendMessage: () {
        context.read<ChatSessionBloc>().add(SendMessageEvent(
            message: ChatMessage(
                sender: Sender.user, content: StringVO(_controller.text))));
        _controller.clear();
        setState(() {
          isKeyboardVisible = false;
        });
      },
      tapped: () {
        setState(() {
          isKeyboardVisible = true;
        });
      },
      controller: _controller,
    );
  }
}

void printInColor(String message, {String color = '\x1B[37m'}) {
  print('$color$message\x1B[0m'); // 메시지를 색상 코드와 함께 출력
}

const String red = '\x1B[31m';
const String green = '\x1B[32m';
const String yellow = '\x1B[33m';
const String blue = '\x1B[34m';
