import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../session/chat_session_bloc.dart';

part 'app_lifecycle_event.dart';

part 'app_lifecycle_state.dart';

@Injectable()
class AppLifecycleBloc extends Bloc<AppLifecycleEvent, AppLifecycleState> {
  final ChatSessionState chatSessionState;

  AppLifecycleBloc(this.chatSessionState) : super(AppLifecycleState.initial()) {
    on<AppResumed>(_onAppResumed);
    on<AppPaused>(_onAppPaused);
  }

  void _onAppPaused(AppPaused event, Emitter<AppLifecycleState> emit) {
    emit(state.copyWith(isResumed: false));
  }

  void _onAppResumed(AppResumed event, Emitter<AppLifecycleState> emit) {
    chatSessionState.copyWith(messages: []); // messages 초기화
    emit(state.copyWith(isResumed: true));
    print("세션을 초기화합니다.");
  }
}
