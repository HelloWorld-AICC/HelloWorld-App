import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'new_chat/application/session/chat_session_bloc.dart';
import 'new_chat/domain/service/stream/chat_session_handler.dart';

//
// import 'locale/domain/localization_service.dart';
//
// @module
// abstract class RegisterModule {
//   @singleton
//   LocalizationService get localizationService => LocalizationService([]);
// }

@module
abstract class RegisterModule {
  @lazySingleton
  ChatSessionHandler get chatSessionHandler =>
      GetIt.instance<ChatSessionBloc>();
}
