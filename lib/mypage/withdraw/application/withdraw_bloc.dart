import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/auth/domain/failure/auth_failure.dart';
import 'package:hello_world_mvp/auth/domain/repository/i_auth_repository.dart';
import 'package:hello_world_mvp/mypage/menu/domain/failure/mypage_failure.dart';
import 'package:hello_world_mvp/mypage/menu/domain/model/my_info.dart';
import 'package:hello_world_mvp/mypage/menu/domain/repository/i_mypage_repository.dart';

import 'package:injectable/injectable.dart';

part 'withdraw_event.dart';
part 'withdraw_state.dart';

@injectable
class WithdrawBloc extends Bloc<WithdrawEvent, WithdrawState> {
  final IAuthRepository authRepository;

  WithdrawBloc({required this.authRepository})
      : super(WithdrawState.initial()) {
    on<Confirmed>((event, emit) async {
      emit(WithdrawState.initial().copyWith(isLoading: true));
      final tokenOrFailure = await authRepository.withdraw();

      emit(tokenOrFailure.fold((f) {
        return state.copyWith(failure: f, isLoading: false);
      }, (myInfo) {
        return state.copyWith(iswithdrawn: true, isLoading: false);
      }));
    });
  }
}
