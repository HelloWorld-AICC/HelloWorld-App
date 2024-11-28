import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/auth/domain/failure/auth_failure.dart';
import 'package:hello_world_mvp/auth/domain/repository/i_auth_repository.dart';
import 'package:hello_world_mvp/mypage/common/domain/failure/mypage_failure.dart';
import 'package:hello_world_mvp/mypage/common/domain/model/my_info.dart';
import 'package:hello_world_mvp/mypage/common/domain/repository/i_mypage_repository.dart';

import 'package:injectable/injectable.dart';

part 'signout_event.dart';
part 'signout_state.dart';

@injectable
class SignOutBloc extends Bloc<SignOutEvent, SignOutState> {
  final IAuthRepository authRepository;

  SignOutBloc({required this.authRepository}) : super(SignOutState.initial()) {
    on<SignOut>((event, emit) async {
      emit(SignOutState.initial().copyWith(isLoading: true));
      final tokenOrFailure = await authRepository.signOut();

      emit(tokenOrFailure.fold((f) {
        return state.copyWith(failure: f, isLoading: false);
      }, (myInfo) {
        return state.copyWith(isSignedOut: true, isLoading: false);
      }));
    });
  }
}
