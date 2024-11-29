import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/new_chat/domain/model/chat_message.dart';
import 'package:hello_world_mvp/new_chat/domain/service/stream/streamed_chat_parse_service.dart';
import 'package:hello_world_mvp/new_chat/domain/service/stream/streamed_chat_service.dart';
import 'package:hello_world_mvp/new_chat/infrastructure/repository/chat_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../core/value_objects.dart';
import '../../domain/failure/chat_failure.dart';

part 'chat_session_event.dart';

part 'chat_session_state.dart';

@injectable
class ChatSessionBloc extends Bloc<ChatSessionEvent, ChatSessionState> {
  final ChatRepository chatRepository;
  final StreamedChatService streamedChatService;

  ChatSessionBloc({
    required this.chatRepository,
    required this.streamedChatService,
  }) : super(ChatSessionState.initial()) {
    on<LoadChatSessionEvent>((event, emit) async {
      emit(state.copyWith(roomId: event.roomId, isLoading: true));
      final roomId = state.roomId;

      if (roomId == null || roomId == 'new_chat') {
        print("불러올 채팅방 기록이 없습니다.");
        emit(state.copyWith(isLoading: false));
        return;
      }
      final failureOrChatRoom =
          await chatRepository.getRoomById(StringVO(event.roomId));

      print("BLOC에서 스트림 챗 서비스의 메모리 주소는 ${streamedChatService.hashCode}");
      print(
          "BLOC에서 스트림 컨트롤러의 메모리 주소는 ${streamedChatService.parseService.messageStream.hashCode}");
      streamedChatService.addChatLogs(failureOrChatRoom);
    });

    on<ChangeRoomIdEvent>((event, emit) {
      emit(state.copyWith(roomId: event.roomId));
    });

    on<UpdateMessagesEvent>((event, emit) {
      emit(state.copyWith(
        messages: event.messages,
        failure: event.failure,
      ));
    });

    on<ChangeLoadingEvent>((event, emit) {
      emit(state.copyWith(
        isLoading: event.isLoading,
        failure: event.failure,
      ));
    });

    on<ClearChatSessionEvent>((event, emit) {
      streamedChatService.clearChatLogs();
      emit(state.copyWith(messages: []));
    });
  }
}
