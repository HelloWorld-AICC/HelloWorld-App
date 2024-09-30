import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/auth/domain/failure/auth_failure.dart';
import 'package:hello_world_mvp/auth/domain/repository/i_token_repository.dart';

import 'package:injectable/injectable.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ITokenRepository tokenRepository;

  HomeBloc({required this.tokenRepository}) : super(HomeState.initial()) {
    on<GetToken>((event, emit) async {
      final tokenOrFailure = await tokenRepository.getTokens();

      emit(tokenOrFailure.fold((f) {
        return state.copyWith(needSignIn: true);
      }, (tokenSet) {
        if (tokenSet.atk != null) {
          return state.copyWith(needSignIn: false);
        } else {
          return state.copyWith(needSignIn: true);
        }
      }));
    });
  }
}
