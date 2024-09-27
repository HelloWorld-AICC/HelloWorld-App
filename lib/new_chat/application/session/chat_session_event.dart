import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_session_event.freezed.dart';

@freezed
class ChatSessionEvent with _$ChatSessionEvent {
  const factory ChatSessionEvent.createNewSession() = CreateNewSessionEvent;

  const factory ChatSessionEvent.loadPrevSession() = LoadPrevSessionEvent;

  const factory ChatSessionEvent.checkSession() = CheckSessionEvent;
}
