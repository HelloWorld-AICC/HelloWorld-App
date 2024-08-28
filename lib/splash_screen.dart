import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed('/firstLaunch');
    });

    return const Scaffold(
      backgroundColor: Colors.blue, // 파란색 배경
      body: Center(
        child: CircularProgressIndicator(), // 로딩 인디케이터
      ),
    );
  }
}
