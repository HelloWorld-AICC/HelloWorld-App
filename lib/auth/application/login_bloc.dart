import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/auth/domain/failure/auth_failure.dart';
import 'package:hello_world_mvp/auth/domain/repository/i_auth_repository.dart';
import 'package:hello_world_mvp/auth/infrastructure/provider/auth_local_provider.dart';

import 'package:injectable/injectable.dart';

import '../../injection.dart';

part 'login_event.dart';

part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final IAuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(LoginState.initial()) {
    on<SignInWithGoogle>((event, emit) async {
      emit(LoginState.initial().copyWith(isLoading: true));
      final tokenOrFailure = await authRepository.getAuthCodeFromGoogle();

      emit(tokenOrFailure.fold((f) {
        return state.copyWith(succeeded: false, failure: f, isLoading: false);
      }, (success) {
        return state.copyWith(succeeded: true, isLoading: false);
      }));
    });

    on<SignOut>((event, emit) async {
      emit(LoginState.initial().copyWith(isLoading: true));
      final tokenOrFailure = await authRepository.signOut();

      emit(tokenOrFailure.fold((f) {
        return state.copyWith(succeeded: false, failure: f, isLoading: false);
      }, (success) {
        return state.copyWith(succeeded: true, isLoading: false);
      }));
    });

    on<RefreshAccessToken>((event, emit) async {
      emit(LoginState.initial().copyWith(isLoading: true));
      final tokens = await getIt<AuthLocalProvier>()
          .getTokens()
          .then((value) => value.getOrElse(() => []));

      final tokenOrFailure =
          await authRepository.refreshAccessTokenIfNeeded(tokens);

      emit(tokenOrFailure.fold((f) {
        return state.copyWith(succeeded: false, failure: f, isLoading: false);
      }, (success) {
        return state.copyWith(succeeded: true, isLoading: false);
      }));
    });
  }
}
