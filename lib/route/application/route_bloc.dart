import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'route_event.dart';

part 'route_state.dart';

@Injectable()
class RouteBloc extends Bloc<RouteEvent, RouteState> {
  // final ChatSessionManager chatSessionBloc;
  // final ActiveChatRoomBloc activeChatRoomBloc;

  RouteBloc(// this.chatSessionBloc, this.roomIdBloc
      )
      : super(RouteState.initial()) {
    on<RouteChanged>(_onRouteChanged);
    on<RouteEventHome>((event, emit) async {
      emit(state.copyWith(
        currentIndex: 2,
        currentRoute: '/home',
      ));
    });
    on<RouteEventLogin>((event, emit) async {
      emit(state.copyWith(
        currentRoute: '/login',
      ));
    });
    on<RouteEventSplash>((event, emit) async {
      emit(state.copyWith(
        currentRoute: '/splash',
      ));
    });
    // on<ChatSelected>(_onChatSelected);
  }

  Future<void> _onRouteChanged(
      RouteChanged event, Emitter<RouteState> emit) async {
    emit(state.copyWith(
      currentIndex: event.newIndex,
      currentRoute: event.newRoute,
    ));
    debugPrint("naviagtion to ${event.newRoute}");
    // if (event.newIndex == 1) {
    //   final roomId = activeChatRoomBloc.state.roomId;
    //   add(ChatSelected(roomId: roomId));
  }
}
