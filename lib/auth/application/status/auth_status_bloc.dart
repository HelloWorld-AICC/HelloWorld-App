import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/auth/domain/repository/i_token_repository.dart';
import 'package:hello_world_mvp/init/application/app_init_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../route/domain/route_service.dart';

part 'auth_status_event.dart';

part 'auth_status_state.dart';

@injectable
class AuthStatusBloc extends Bloc<AuthStatusEvent, AuthStatusState> {
  final AppInitBloc appInitBloc;
  final ITokenRepository tokenRepository;
  final RouteService routeService;

  AuthStatusBloc({
    required this.tokenRepository,
    required this.appInitBloc,
    required this.routeService,
  }) : super(AuthStatusState.initial()) {
    on<CheckAuthStatus>((event, emit) async {
      print('AuthStatusBloc :: CheckAuthStatus event has been called');
      final isFirstRun = appInitBloc.state.isFirstRun;

      final tokensOrFailure = await tokenRepository.getTokens();

      emit(tokensOrFailure.fold(
        (failure) => state.copyWith(isSignedIn: false, isLoading: false),
        (tokens) => state.copyWith(
          isSignedIn: true,
          isLoading: false,
          isFirstRun: isFirstRun,
        ),
      ));
    });
    on<MarkSignedIn>((event, emit) async {
      final tokensOrFailure = await tokenRepository.getTokens();
      final isSignedIn = tokensOrFailure.isRight();
      if (!isSignedIn) {
        routeService.redirectToLoginPage();
      } else {
        routeService.redirectToHomePage();
      }
    });
  }
}
