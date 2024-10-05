import 'package:flutter/material.dart';

class TypingIndicator extends StatefulWidget {
  @override
  _TypingIndicatorState createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(); // Start the animation
  }

  @override
  void dispose() {
    _animationController.dispose(); // Dispose of the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Create an animated dot that scales in and out
        ScaleTransition(
          scale: Tween<double>(begin: 1.0, end: 1.5).animate(CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          )),
          child: const CircleAvatar(radius: 5.0, backgroundColor: Colors.blue),
        ),
        const SizedBox(width: 4.0), // Spacing between dots
        ScaleTransition(
          scale: Tween<double>(begin: 1.0, end: 1.5).animate(CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          )),
          child: const CircleAvatar(radius: 5.0, backgroundColor: Colors.blue),
        ),
        const SizedBox(width: 4.0), // Spacing between dots
        ScaleTransition(
          scale: Tween<double>(begin: 1.0, end: 1.5).animate(CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          )),
          child: const CircleAvatar(radius: 5.0, backgroundColor: Colors.blue),
        ),
        const SizedBox(width: 8.0), // Spacing after dots
        const Text("Typing..."),
      ],
    );
  }
}
