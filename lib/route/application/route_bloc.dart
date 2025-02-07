import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/route/domain/service/route_service.dart';
import 'package:injectable/injectable.dart';

import '../../injection.dart';

part 'route_event.dart';

part 'route_state.dart';

@Injectable()
class RouteBloc extends Bloc<RouteEvent, RouteState> {
  // final ChatSessionManager chatSessionBloc;
  // final ActiveChatRoomBloc activeChatRoomBloc;

  BuildContext? context;

  RouteBloc(// this.chatSessionBloc, this.roomIdBloc
      )
      : super(RouteState.initial()) {
    on<RouteChanged>(_onRouteChanged);
  }

  Future<void> _onRouteChanged(
      RouteChanged event, Emitter<RouteState> emit) async {
    emit(state.copyWith(
      currentIndex: event.newIndex,
    ));
  }
}
