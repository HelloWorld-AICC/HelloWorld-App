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
  BuildContext? context;

  RouteBloc() : super(RouteState.initial()) {
    on<RouteChanged>(_onRouteChanged);
  }

  Future<void> _onRouteChanged(
      RouteChanged event, Emitter<RouteState> emit) async {
    emit(state.copyWith(
      currentIndex: event.newIndex,
    ));
    // router.push("/${event.newRoute}");
  }
}
