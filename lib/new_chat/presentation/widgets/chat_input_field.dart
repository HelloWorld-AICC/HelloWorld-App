import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/new_chat/presentation/widgets/new_chat_content.dart';

import '../../../design_system/hello_colors.dart';
import '../../application/session/chat_session_bloc.dart';

class ChatInputField extends StatelessWidget {
  final TextEditingController controller;
  final Function sendMessage;
  final Function tapped;

  const ChatInputField({
    Key? key,
    required this.controller,
    required this.sendMessage,
    required this.tapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatSessionBloc, ChatSessionState>(
      listenWhen: (previous, current) {
        return previous.blockInput != current.blockInput;
      },
      listener: (context, state) {
        if (state.blockInput) {
          print('ChatInputField :: build :: blockInput=true');
          return;
        }
        print('ChatInputField :: build :: blockInput=false');
      },
      builder: (context, state) {
        bool blockInput = !state.blockInput;
        Color backgroundColor = blockInput ? Colors.white : Colors.grey[100]!;
        Color textColor = blockInput ? HelloColors.mainColor1 : Colors.grey;
        Color borderColor =
            blockInput ? HelloColors.subTextColor : Colors.grey[100]!;
        Color iconColor =
            blockInput ? HelloColors.mainColor1 : HelloColors.gray;
        // print('ChatInputField :: build :: blockInput=$blockInput');

        return Padding(
          padding: const EdgeInsets.all(32.0),
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: borderColor),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    enabled: blockInput,
                    style: TextStyle(
                      fontFamily: "SB AggroOTF",
                      fontSize: 12,
                      color: textColor,
                    ),
                    decoration: InputDecoration(
                      hintText: blockInput ? '상담하고자 하는 내용을 입력하세요' : '',
                      hintStyle: TextStyle(
                        fontFamily: "SB AggroOTF",
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: HelloColors.mainColor1,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    onSubmitted: (value) {
                      context.read<ChatSessionBloc>().add(
                          ChangeLoadingEvent(isLoading: true, failure: null));
                      controller.clear();
                      sendMessage();
                    },
                    onTap: () {
                      tapped();
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    size: 20,
                    color: iconColor,
                  ),
                  onPressed: blockInput
                      ? () {
                          context
                              .read<ChatSessionBloc>()
                              .add(ChangeBlockInputEvent(blockInput: true));
                          sendMessage();
                        }
                      : null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
