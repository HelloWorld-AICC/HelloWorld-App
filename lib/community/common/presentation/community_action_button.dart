import 'package:flutter/material.dart';
import 'package:hello_world_mvp/design_system/hello_colors.dart';
import 'package:hello_world_mvp/design_system/hello_fonts.dart';

class CommunityActionButton extends StatelessWidget {
  final String text;
  final Color buttonColor;
  final Function onTap;

  const CommunityActionButton(
      {super.key,
      required this.text,
      required this.buttonColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        width: 53,
        height: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: HelloColors.white,
          boxShadow: [
            BoxShadow(
              color: buttonColor, // #6D9CD5를 Flutter Color로 변환
              blurRadius: 4.0, // 그림자의 흐림 정도
              spreadRadius: 0.0, // 그림자의 확산 정도
              offset: const Offset(0, 0), // 그림자의 위치 (x, y)
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              height: 16 / 12,
              fontFamily: HelloFonts.sbAggroOTF,
              color: buttonColor,
            ),
          ),
        ),
      ),
    );
  }
}
