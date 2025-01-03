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
    return BlocBuilder<ChatSessionBloc, ChatSessionState>(
      builder: (context, state) {
        bool isEnabled = !state.isLoading;
        Color backgroundColor = isEnabled ? Colors.white : Colors.grey[100]!;
        Color borderColor =
            isEnabled ? HelloColors.subTextColor : Colors.grey[100]!;
        Color iconColor = isEnabled ? HelloColors.mainColor1 : HelloColors.gray;

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
                    enabled: isEnabled,
                    style: const TextStyle(
                      fontFamily: "SB AggroOTF",
                      fontSize: 12,
                      color: HelloColors.mainColor1,
                    ),
                    decoration: InputDecoration(
                      hintText: isEnabled ? '상담하고자 하는 내용을 입력하세요' : '',
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
                      sendMessage();
                      controller.clear();
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
                  onPressed: isEnabled
                      ? () {
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
