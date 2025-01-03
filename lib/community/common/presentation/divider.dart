import 'package:flutter/material.dart';

class Divider extends StatelessWidget {
  const Divider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(vertical: 16),
      color: const Color.fromRGBO(173, 173, 173, 0.20),
    );
  }
}
