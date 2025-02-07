import 'dart:async';
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../core/value_objects.dart';
import '../../../custom_bottom_navigationbar.dart';
import '../../../design_system/hello_colors.dart';
import '../../../fetch/authenticated_http_client.dart';
import '../../../injection.dart';
import '../../../route/application/route_bloc.dart';
import '../../application/drawer/chat_drawer_bloc.dart';
import '../../application/session/chat_session_bloc.dart';
import '../../domain/chat_enums.dart';
import '../../domain/model/chat_message.dart';
import '../../domain/service/stream/streamed_chat_service.dart';
import 'chat_appbar.dart';
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

  final ScrollController _scrollController = ScrollController();

  bool isKeyboardVisible = false;

  String? roomId;

  late StreamedChatService streamedChatService;

  late StreamController<ChatMessage> _streamController;

  @override
  void initState() {
    super.initState();

    streamedChatService = getIt<StreamedChatService>();

    _streamController = StreamController<ChatMessage>.broadcast();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final chatSessionBloc = context.read<ChatSessionBloc>();
      if (chatSessionBloc.state.roomId == null &&
          chatSessionBloc.state.isLoading) {
        chatSessionBloc.add(LoadChatSessionEvent(roomId: 'new_chat'));
      }
      _scrollToBottom();
    });

    // print("새로운 채팅방을 생성합니다.");
    // _streamController
    //     .add(ChatMessage(sender: Sender.bot, content: StringVO("안녕하세요!")));
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String? roomId = context.read<ChatSessionBloc>().state.roomId;

    return BlocBuilder<ChatSessionBloc, ChatSessionState>(
        builder: (context, state) {
      return SafeArea(
        child: PopScope(
          onPopInvoked: (result) {},
          child: Scaffold(
            key: _scaffoldKey,
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            appBar: ChatAppbar(scaffoldKey: _scaffoldKey),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: BlocBuilder<ChatSessionBloc, ChatSessionState>(
                        builder: (context, state) {
                      if (state.roomId == "new_chat") {
                        // 채팅 가이드 위젯 삭제
                        // return Padding(
                        //   padding: const EdgeInsets.only(
                        //     top: 10,
                        //     left: 10,
                        //     right: 100,
                        //     bottom: 200,
                        //   ),
                        //   child: ChatGuideWidget(),
                        // );
                      }

                      return StreamBuilder<ChatMessage>(
                        stream: _streamController.stream,
                        builder: (context, snapshot) {
                          // print("채팅방 ID: ${state.roomId}");

                          final updatedMessages =
                              List<ChatMessage>.from(state.messages);
                          // List<ChatMessage> updatedMessages = [];

                          if (snapshot.connectionState ==
                                  ConnectionState.active ||
                              snapshot.connectionState ==
                                  ConnectionState.done) {
                            if (snapshot.hasData) {
                              // print(formatMessage(
                              //     "새로운 메시지가 도착했습니다: ${snapshot.data.toString()}",
                              //     200));
                              // updatedMessages.add(snapshot.data!);
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                _scrollToBottom();
                              });
                            }

                            return NoStreamMessageListWidget(
                              messages: updatedMessages,
                              roomId: roomId,
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return NoStreamMessageListWidget(
                              messages: updatedMessages,
                              roomId: roomId,
                            );
                          } else {
                            // 스트림이 완료된 후 처리할 사항
                            return Text("스트림이 종료되었습니다.");
                          }
                        },
                      );
                    }
                        // },
                        ),
                  ),
                  _buildInputArea(roomId ?? 'new_chat'),
                ],
              ),
            ),
            bottomNavigationBar: Visibility(
              visible: !isKeyboardVisible,
              child: CustomBottomNavigationBar(),
            ),
            drawer: ChatRoomsDrawer(streamController: _streamController),
            onDrawerChanged: (isOpen) {
              if (!isOpen) {
                final selectedRoomId =
                    context.read<ChatDrawerBloc>().state.selectedRoomId;
                context.read<ChatDrawerBloc>().add(CloseDrawerEvent(
                    selectedRoomId: selectedRoomId == "new_chat"
                        ? context.read<ChatSessionBloc>().state.roomId
                        : selectedRoomId));
                if (selectedRoomId != null) {
                  context
                      .read<ChatSessionBloc>()
                      .add(ChangeRoomIdEvent(roomId: selectedRoomId));
                }
              }
            },
          ),
        ),
      );
    });
  }

  Widget _buildInputArea(String roomId) {
    return BlocConsumer<ChatSessionBloc, ChatSessionState>(
      listener: (context, state) {},
      builder: (context, state) => ChatInputField(
        sendMessage: () async {
          if (_controller.text.isEmpty || _controller.text == " ") return;

          final messageToSend = _controller.text;
          context.read<ChatSessionBloc>().add(UpdateMessagesEvent(messages: [
                ...context.read<ChatSessionBloc>().state.messages,
                ChatMessage(
                    sender: Sender.user, content: StringVO(messageToSend))
              ], isLoading: true, failure: null));

          // WidgetsBinding.instance.addPostFrameCallback((_) {
          //   _scrollController.animateTo(
          //     _scrollController.position.maxScrollExtent,
          //     duration: Duration(milliseconds: 300),
          //     curve: Curves.easeOut,
          //   );
          // });

          const String authority = "www.gotoend.store";
          final queryParams = {'roomId': roomId};
          final uri = Uri.https(authority, "webflux/chat/ask", queryParams);

          final request = http.Request("POST", uri);

          request.headers['accept'] = 'text/event-stream';
          final bodyParams = {'content': messageToSend};
          request.body = json.encode(bodyParams);

          final streamedResponse =
              await getIt<AuthenticatedHttpClient>().send(request);

          ChatMessage? botMessage;
          final finalResponse = StringBuffer();

          streamedResponse.stream.transform(utf8.decoder).listen((line) {
            // print('Received line: $line');

            if (line.startsWith('data:')) {
              var temp = line.substring(5).trim();
              // print('Processed temp: $temp');

              if (temp.isEmpty) {
                temp = ' ';
                // print('Temp was empty, setting to space');
              }

              if (line.startsWith('data:Room ID: ')) {
                // print('Room ID found: $temp');
                roomId = temp;
                context
                    .read<ChatSessionBloc>()
                    .add(ChangeRoomIdEvent(roomId: roomId));
                return;
              } else {
                if (temp == 'data:') {
                  // print('Data is empty, appending newline');
                  finalResponse.write('\n');
                } else {
                  // print('Appending content: $temp');
                  finalResponse.write(temp);
                }

                if (botMessage == null) {
                  // print('Creating new bot message');
                  botMessage = ChatMessage(
                    sender: Sender.bot,
                    content: StringVO(finalResponse.toString()),
                  );

                  _streamController.add(botMessage!);
                  final updatedMessages = context
                      .read<ChatSessionBloc>()
                      .state
                      .messages
                    ..add(botMessage!);

                  context.read<ChatSessionBloc>().add(UpdateMessagesEvent(
                      messages: updatedMessages,
                      isLoading: false,
                      failure: null));
                  // print('Updated messages (new bot message): $updatedMessages');
                } else {
                  // print('Updating bot message content');

                  botMessage = botMessage!.copyWith(
                    content: StringVO(finalResponse.toString()),
                  );
                  _streamController.add(botMessage!);

                  // final updatedMessages = context
                  //     .read<ChatSessionBloc>()
                  //     .state
                  //     .messages
                  //     .map((message) => message.content == botMessage!.content
                  //         ? botMessage!
                  //         : message)
                  //     .toList();

                  // final updatedMessages = context
                  //     .read<ChatSessionBloc>()
                  //     .state
                  //     .messages
                  //     .map((message) =>
                  //         message.sender == Sender.bot ? botMessage! : message)
                  //     .toList();

                  List<ChatMessage> updatedMessages =
                      List.from(context.read<ChatSessionBloc>().state.messages);

                  if (updatedMessages.isNotEmpty) {
                    final lastMessageIndex = updatedMessages.length - 1;
                    final lastMessage = updatedMessages[lastMessageIndex];
                    if (lastMessage.sender == Sender.bot) {
                      updatedMessages[lastMessageIndex] = botMessage!;
                    }
                  }

                  context.read<ChatSessionBloc>().add(UpdateMessagesEvent(
                      messages: updatedMessages,
                      isLoading: false,
                      failure: null));
                  _streamController.add(botMessage!);
                  // print('Updated messages (modified bot message): $botMessage');
                }
              }
            }
          }, onDone: () {
            context
                .read<ChatSessionBloc>()
                .add(ChangeBlockInputEvent(blockInput: false));
            _controller.clear();
            print("사용자 메시지와 봇 메시지 전송이 완료되었고, 스트림이 종료되었습니다.");
          });

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
