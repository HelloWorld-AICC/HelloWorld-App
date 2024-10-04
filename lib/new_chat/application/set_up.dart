import 'package:get_it/get_it.dart';
import 'package:hello_world_mvp/new_chat/application/app/init/app_init_bloc.dart';

import '../../injection.dart';
import '../domain/service/chat/chat_service.dart';
import 'app/lifecycle/app_lifecycle_bloc.dart';
import 'app/navigation/tab_navigation_bloc.dart';
import 'chat/roomId/room_id_bloc.dart';
import 'chat/session/chat_session_bloc.dart';

void setupServiceLocator() {
  getIt.registerLazySingleton<ChatService>(() => ChatService());
  getIt.registerFactory<CustomAppLifecycleBloc>(
      () => CustomAppLifecycleBloc(getIt<ChatSessionBloc>().state));
  getIt.registerFactory<ChatSessionBloc>(
      () => ChatSessionBloc(chatService: getIt<ChatService>()));
  getIt.registerFactory<TabNavigationBloc>(
      () => TabNavigationBloc(getIt<ChatSessionBloc>(), getIt<RoomIdBloc>()));
  getIt.registerFactory<RoomIdBloc>(() => RoomIdBloc());
  getIt.registerFactory<AppInitBloc>(() => AppInitBloc());
}
