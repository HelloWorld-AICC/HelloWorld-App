import 'package:flutter/material.dart';

import '../../../design_system/hello_colors.dart';

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
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: HelloColors.subTextColor),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                style: const TextStyle(
                  fontFamily: "SB AggroOTF",
                  fontSize: 12,
                  color: HelloColors.mainColor1,
                ),
                decoration: const InputDecoration(
                  hintText: '상담하고자 하는 내용을 입력하세요',
                  hintStyle: TextStyle(
                    fontFamily: "SB AggroOTF",
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: HelloColors.mainColor1,
                  ),
                  border: InputBorder.none, // TextField 자체의 border를 제거합니다.
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
                onSubmitted: (value) {
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
                color: HelloColors.mainColor1,
              ),
              onPressed: () {
                sendMessage();
              },
            ),
          ],
        ),
      ),
    );
  }
}
