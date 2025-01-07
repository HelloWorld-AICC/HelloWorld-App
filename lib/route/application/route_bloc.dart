import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../../injection.dart';
import '../domain/route_service.dart';

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
    on<PopEvent>((event, emit) async {
      emit(state.copyWith(
        currentIndex: 2,
        currentRoute: '/home',
      ));
      getIt<RouteService>().router.pop();
      print("RouteBloc에서 pop");
    });
    // on<ChatSelected>(_onChatSelected);
  }

  Future<void> _onRouteChanged(
      RouteChanged event, Emitter<RouteState> emit) async {
    emit(state.copyWith(
      currentIndex: event.newIndex,
      currentRoute: event.newRoute,
    ));
    getIt<RouteService>().router.push("/${event.newRoute}");
  }
}
