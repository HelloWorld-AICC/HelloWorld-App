import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../session/chat_session_bloc.dart';

part 'app_lifecycle_event.dart';

part 'app_lifecycle_state.dart';

@Injectable()
class CustomAppLifecycleBloc
    extends Bloc<CustomAppLifecycleEvent, CustomAppLifecycleState> {
  final ChatSessionState chatSessionState;

  CustomAppLifecycleBloc(this.chatSessionState)
      : super(CustomAppLifecycleState.initial()) {
    on<CustomAppResumed>(_onAppResumed);
    on<CustomAppPaused>(_onAppPaused);
  }

  void _onAppPaused(
      CustomAppPaused event, Emitter<CustomAppLifecycleState> emit) {
    emit(state.copyWith(isResumed: false));
  }

  void _onAppResumed(
      CustomAppResumed event, Emitter<CustomAppLifecycleState> emit) {
    chatSessionState.copyWith(messages: []); // messages 초기화
    emit(state.copyWith(isResumed: true));
    print("세션을 초기화합니다.");
  }
}
