import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/new_chat/application/drawer/chat_drawer_bloc.dart';

import '../../injection.dart';
import '../../route/application/route_bloc.dart';
import '../application/session/chat_session_bloc.dart';
import 'widgets/new_chat_content.dart';

class NewChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ChatDrawerBloc>(),
        )
      ],
      child: Scaffold(
        body: NewChatContent(),
        // bottomNavigationBar: CustomBottomNavigationBar(),
      ),
    );
  }
}
