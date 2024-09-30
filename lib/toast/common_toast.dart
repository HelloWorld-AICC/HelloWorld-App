import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/injection.dart';
import 'package:hello_world_mvp/toast/toast_bloc.dart';

showToast(String message) {
  getIt<ToastBloc>().add(Show(message: message));
}

class CommonToast extends StatefulWidget {
  final String? message;

  const CommonToast({super.key, this.message});

  @override
  State createState() => CommonToastState();
}

class CommonToastState extends State<CommonToast>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInOut;
  late Animation<double> _scale;
  Timer? _timer;

  String? message = "";

  @override
  void initState() {
    super.initState();
    message = widget.message;

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeInOut = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
      reverseCurve: const Interval(0.8, 1.0, curve: Curves.easeIn),
    ));

    _scale = Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
      // reverseCurve: const Interval(1.0, 1.0, curve: Curves.easeIn),
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    _cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (message?.isNotEmpty == true) {
      _startAnimation();
    } else {
      return const SizedBox();
    }

    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _fadeInOut.value,
            child: Transform.scale(
              scale: _scale.value,
              child: child,
            ),
          );
        },
        child: IgnorePointer(
          ignoring: true,
          child: Center(
            child: Wrap(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 32,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                  ),
                  child: Center(
                    child: Text(
                      message ?? "",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: "Pretendard",
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          height: 20 / 14,
                          letterSpacing: 0.25),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  _startAnimation() {
    _controller.forward();
    _timer = Timer(const Duration(milliseconds: 1500), () {
      _controller.reverse();
      context.read<ToastBloc>().add(Reset());
    });
  }

  updateMessage(String? newMessage) {
    _controller.reset();
    _cancelTimer();
    setState(() {
      message = newMessage;
    });
  }

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }
}
