import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/auth/domain/failure/auth_failure.dart';
import 'package:hello_world_mvp/auth/domain/repository/i_auth_repository.dart';
import 'package:hello_world_mvp/mypage/menu/domain/failure/mypage_failure.dart';
import 'package:hello_world_mvp/mypage/menu/domain/model/my_info.dart';
import 'package:hello_world_mvp/mypage/menu/domain/repository/i_mypage_repository.dart';

import 'package:injectable/injectable.dart';

part 'mypage_event.dart';
part 'mypage_state.dart';

@injectable
class MypageBloc extends Bloc<MypageEvent, MypageState> {
  final IMypageRepository myPageRepository;

  MypageBloc({required this.myPageRepository}) : super(MypageState.initial()) {
    on<GetMyInfo>((event, emit) async {
      emit(MypageState.initial().copyWith(isLoading: true));
      final tokenOrFailure = await myPageRepository.getMyInfo();

      emit(tokenOrFailure.fold((f) {
        return state.copyWith(failure: f, isLoading: false);
      }, (myInfo) {
        return state.copyWith(myInfo: myInfo, isLoading: false);
      }));
    });
  }
}
