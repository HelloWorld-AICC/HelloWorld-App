import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/auth/domain/failure/auth_failure.dart';
import 'package:hello_world_mvp/auth/domain/repository/i_auth_repository.dart';

import 'package:injectable/injectable.dart';

part 'login_event.dart';
part 'login_state.dart';

@lazySingleton
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final IAuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(LoginState.initial()) {
    on<SignInWithGoogle>((event, emit) async {
      final tokenOrFailure = await authRepository.getAuthCodeFromGoogle();

      emit(tokenOrFailure.fold((f) {
        return state.copyWith(succeeded: false, failure: f);
      }, (success) {
        return state.copyWith(succeeded: true);
      }));
    });
  }
}
