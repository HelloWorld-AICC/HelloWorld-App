import 'package:flutter/material.dart';

class SplashTextLabel extends StatelessWidget {
  final String text;

  const SplashTextLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 2;

    return Container(
      width: width,
      constraints: BoxConstraints(
        minHeight: 36,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: Color(0xFFB3D4E0),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(
            text,
            style: TextStyle(
              fontFamily: "SB AggroOTF",
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xff6D9CD5),
            ),
          ),
        ),
      ),
    );
  }
}
