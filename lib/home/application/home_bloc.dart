import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/auth/domain/repository/i_token_repository.dart';
import 'package:hello_world_mvp/bus/bus.dart';
import 'package:hello_world_mvp/bus/bus_message.dart';
import 'package:hello_world_mvp/home/application/home_messages.dart';

import 'package:injectable/injectable.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ITokenRepository tokenRepository;
  final Bus bus;
  late StreamSubscription<BusMessage> busSubscription;

  @override
  Future<void> close() {
    busSubscription.cancel();
    return super.close();
  }

  HomeBloc({required this.tokenRepository, required this.bus})
      : super(HomeState.initial()) {
    busSubscription = bus.subscribe((message) {
      if (message is AuthFailedMessage) {
        add(GetToken());
      }
    });

    on<GetToken>((event, emit) async {
      final tokenOrFailure = await tokenRepository.getTokens();

      emit(tokenOrFailure.fold((f) {
        return state.copyWith(needSignIn: true);
      }, (tokenSet) {
        if (tokenSet.atk != null &&
            tokenSet.rtk!.tokenExpiresTime
                .getOrCrash()
                .isAfter(DateTime.now())) {
          return state.copyWith(needSignIn: false);
        } else {
          return state.copyWith(needSignIn: true);
        }
      }));
    });
  }
}
