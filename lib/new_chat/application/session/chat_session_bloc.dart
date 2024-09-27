import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/new_chat/application/service/chat_service.dart';
import 'package:hello_world_mvp/new_chat/application/session/chat_session_event.dart';
import 'package:hello_world_mvp/new_chat/application/session/chat_session_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatSessionBloc extends Bloc<ChatSessionEvent, ChatSessionState> {
  final ChatService chatService;

  ChatSessionBloc({
    required this.chatService,
  }) : super(ChatSessionState.newSession()) {
    // Set the initial state to new session

    on<ChatSessionEvent>((event, emit) async {
      await event.map(
        createNewSession: (e) async {
          log("[ChatSessionBloc] Creating new session");
          emit(const ChatSessionState.newSession());
          chatService.clearChat();
        },
        loadPrevSession: (e) async {
          log("[ChatSessionBloc] Loading previous session");
          emit(const ChatSessionState.prevSession());
        },
        checkSession: (e) async {
          await checkAppState();
        },
      );
    });
  }

  Future<void> checkAppState() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
    final isNewSession = prefs.getBool('isNewSession') ?? true;

    if (isFirstLaunch) {
      log('[ChatSessionBloc] Confirmed First launch');
      await prefs.setBool('isFirstLaunch', false);
      add(const ChatSessionEvent.createNewSession());
    } else if (isNewSession) {
      log('[ChatSessionBloc] Confirmed New session');
      add(const ChatSessionEvent.createNewSession());
    } else {
      log('[ChatSessionBloc] Confirmed Previous session');
      add(const ChatSessionEvent.loadPrevSession());
    }
  }
}
