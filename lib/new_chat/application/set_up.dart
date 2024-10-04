import 'package:get_it/get_it.dart';
import 'package:hello_world_mvp/new_chat/application/session/chat_session_bloc.dart';

import '../../injection.dart';
import '../domain/service/chat/chat_service.dart';
import 'app/lifecycle/app_lifecycle_bloc.dart';
import 'navigation/roomId/room_id_bloc.dart';
import 'navigation/tab/tab_navigation_bloc.dart';

void setupServiceLocator() {
  getIt.registerLazySingleton<ChatService>(() => ChatService());
  getIt.registerFactory<CustomAppLifecycleBloc>(
      () => CustomAppLifecycleBloc(getIt<ChatSessionBloc>().state));
  getIt.registerFactory<RoomIdBloc>(() => RoomIdBloc());
  getIt.registerFactory<ChatSessionBloc>(
      () => ChatSessionBloc(chatService: getIt<ChatService>()));
  getIt.registerFactory<TabNavigationBloc>(
      () => TabNavigationBloc(getIt<ChatSessionBloc>(), getIt<RoomIdBloc>()));
}
