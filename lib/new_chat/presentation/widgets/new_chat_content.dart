import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/new_chat/presentation/widgets/typing_indicator.dart';

import '../../../core/value_objects.dart';
import '../../../custom_bottom_navigationbar.dart';
import '../../../home/presentation/widgets/home_page_content.dart';
import '../../application/session/chat_session_bloc.dart';
import '../../domain/chat_enums.dart';
import '../../domain/model/chat_message.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          tr('chat_title'),
          style: TextStyle(
            color: const Color(0xFF6D9CD5),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.list_rounded,
            color: Color(0xFF6D9CD5),
          ),
          color: const Color(0xff002E4F),
          onPressed: () {
            // context
            //     .read<RouteBloc>()
            //     .add(RouteChanged(newIndex: 0, newRoute: '/home'));
            // Navigator.of(context).pop();
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Color(0xFF6D9CD5),
            ),
            onPressed: () {
              context.read<ChatSessionBloc>().add(ClearMessagesEvent());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: BlocBuilder<ChatSessionBloc, ChatSessionState>(
                bloc: context.read<ChatSessionBloc>(),
                builder: (context, state) {
                  return MessageListWidget(messages: state.messages ?? []);
                },
              ),
            ),
            if (context.watch<ChatSessionBloc>().state.typingState ==
                TypingIndicatorState.shown)
              TypingIndicator(),
            // Expanded(
            //   child: ActionButtonsWidget(
            //     onButtonPressed: (selectedContent) {},
            //   ),
            // ),
            _buildInputArea(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(items: bottomNavItems),
      drawer: ChatRoomsDrawer(),
    );
  }

  Widget _buildInputArea() {
    return ChatInputField(
      sendMessage: () {
        context.read<ChatSessionBloc>().add(SendMessageEvent(
            message: ChatMessage(
                sender: Sender.user, content: StringVO(_controller.text))));
        _controller.clear();
      },
      controller: _controller,
    );
  }
}
