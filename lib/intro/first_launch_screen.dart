import 'package:flutter/material.dart';

class FirstLaunchScreen extends StatelessWidget {
  const FirstLaunchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Hello World'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to Hello World'),
            Text('This is your first time using the app'),
          ],
        ),
      ),
    );
  }
}
