import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/value_objects.dart';
import '../../../custom_bottom_navigationbar.dart';
import '../../../design_system/hello_colors.dart';
import '../../../injection.dart';
import '../../application/drawer/chat_drawer_bloc.dart';
import '../../application/session/chat_session_bloc.dart';
import '../../domain/chat_enums.dart';
import '../../domain/model/chat_message.dart';
import '../../domain/service/chat_fetch_service.dart';
import '../../domain/service/stream/streamed_chat_parse_service.dart';
import '../../domain/service/stream/streamed_chat_service.dart';
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

  late StreamedChatService streamedChatService;

  @override
  void initState() {
    super.initState();

    streamedChatService = getIt<StreamedChatService>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final chatSessionBloc = context.read<ChatSessionBloc>();
      if (chatSessionBloc.state.roomId == null &&
          chatSessionBloc.state.isLoading) {
        chatSessionBloc.add(LoadChatSessionEvent(roomId: 'new_chat'));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String? roomId = context.read<ChatSessionBloc>().state.roomId;

    return BlocBuilder<ChatSessionBloc, ChatSessionState>(
        builder: (context, state) {
      print("ChatContent에서 스트림 챗 서비스의 메모리 주소는 ${streamedChatService.hashCode}");
      print(
          "ChatContent에서 스트림 컨트롤러의 메모리 주소는 ${streamedChatService.parseService.messageStream.hashCode}");

      return SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
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
              color: HelloColors.subTextColor,
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
                  color: HelloColors.subTextColor,
                ),
                onPressed: () {
                  context.read<ChatSessionBloc>().add(ClearChatSessionEvent());
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
                    builder: (context, state) {
                      if (state.roomId == "new_chat") {
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
                        return MessageListWidget(
                          messageStream:
                              streamedChatService.parseService.messageStream,
                          roomId: state.roomId,
                        );
                      }
                    },
                  ),
                ),
                // if (context.watch<ChatSessionBloc>().state.typingState ==
                //     TypingIndicatorState.shown)
                //   TypingIndicator(),
                // Expanded(
                //   child: ActionButtonsWidget(
                //     onButtonPressed: (selectedContent) {},
                //   ),
                // ),
                _buildInputArea(roomId ?? 'new_chat'),
              ],
            ),
          ),
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
    });
  }

  Widget _buildInputArea(String roomId) {
    return BlocListener<ChatSessionBloc, ChatSessionState>(
      listener: (context, state) {},
      child: ChatInputField(
        sendMessage: () {
          ChatMessage userMessage = ChatMessage(
              sender: Sender.user, content: StringVO(_controller.text));
          streamedChatService.parseService.addMessage(userMessage);
          streamedChatService.sendUserRequest(
            userMessage,
            roomId,
            onDone: () {
              context
                  .read<ChatSessionBloc>()
                  .add(ChangeRoomIdEvent(roomId: roomId));
            },
          );

          context.read<ChatSessionBloc>().add(UpdateMessagesEvent(messages: [
                ...context.read<ChatSessionBloc>().state.messages,
                userMessage
              ], isLoading: false, failure: null));

          _controller.clear();
          setState(() {
            isKeyboardVisible = false;
          });
        },
        tapped: () {
          setState(() {
            isKeyboardVisible = true;
            // context
            //     .read<ChatSessionBloc>()
            //     .add(ChangeRoomIdEvent(roomId: 'new_chat'));
          });
        },
        controller: _controller,
      ),
    );
  }
}
