import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/new_chat/application/message/chat_message_bloc.dart';
import 'package:hello_world_mvp/new_chat/application/service/chat_service.dart';
import 'package:hello_world_mvp/new_chat/application/session/chat_session_bloc.dart';
import 'package:hello_world_mvp/new_chat/domain/chat_repository.dart';
import 'package:hello_world_mvp/new_chat/infrastructure/i_chat_repository.dart';
import 'package:hello_world_mvp/new_chat/presentation/chat_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('isFirstLaunch', true);
  prefs.setBool('isNewSession', true);

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ko', 'KR'),
        Locale('ja', 'JP'),
        Locale('zh', 'CN'),
        Locale('vi', 'VN'),
      ],
      startLocale: const Locale('en', 'US'),
      path: 'assets/translations',
      child: MultiBlocProvider(
        providers: [
          Provider<ChatRepository>(
            create: (_) => IChatRepository(),
          ),
          Provider<ChatService>(
            create: (context) => ChatService(
              chatRepository: context.read<ChatRepository>(),
              baseUrl: 'https://www.gotoend.store/webflux',
              accessToken: '1',
            ),
          ),
          BlocProvider<ChatSessionBloc>(
            create: (context) => ChatSessionBloc(
              chatService: context.read<ChatService>(),
            ),
          ),
          BlocProvider<ChatMessageBloc>(
            create: (context) => ChatMessageBloc(
              chatSessionBloc: context.read<ChatSessionBloc>(),
              chatService: context.read<ChatService>(),
            ),
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello World MVP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NewChatPage(),
      routes: {
        '/newChat': (context) => NewChatPage(),
      },
    );
  }
}
