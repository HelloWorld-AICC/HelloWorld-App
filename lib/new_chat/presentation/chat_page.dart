import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hello_world_mvp/new_chat/application/session/chat_session_bloc.dart';
import 'package:hello_world_mvp/new_chat/application/session/chat_session_event.dart';
import 'package:hello_world_mvp/new_chat/presentation/widgets/chat_form.dart';

class NewChatPage extends HookWidget {
  const NewChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      return null;
    }, []);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<ChatSessionBloc>()
          .add(const ChatSessionEvent.checkSession());
    });

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[200],
          title: Text(
            tr('chat_consultation'),
            style: TextStyle(
              color: Color(0xff3369FF),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        body: ChatForm(),
      ),
    );
  }
}
