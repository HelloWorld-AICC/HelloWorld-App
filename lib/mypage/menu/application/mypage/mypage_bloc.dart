import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/auth/domain/failure/auth_failure.dart';
import 'package:hello_world_mvp/auth/domain/repository/i_auth_repository.dart';
import 'package:hello_world_mvp/bus/bus.dart';
import 'package:hello_world_mvp/bus/bus_message.dart';
import 'package:hello_world_mvp/mypage/common/application/mypage_messages.dart';
import 'package:hello_world_mvp/mypage/menu/domain/failure/mypage_failure.dart';
import 'package:hello_world_mvp/mypage/menu/domain/model/my_info.dart';
import 'package:hello_world_mvp/mypage/menu/domain/repository/i_mypage_repository.dart';

import 'package:injectable/injectable.dart';

part 'mypage_event.dart';
part 'mypage_state.dart';

@injectable
class MypageBloc extends Bloc<MypageEvent, MypageState> {
  final IMypageRepository myPageRepository;
  final Bus bus;
  late StreamSubscription<BusMessage> busSubscription;

  @override
  Future<void> close() {
    busSubscription.cancel();
    return super.close();
  }

  MypageBloc({required this.myPageRepository, required this.bus})
      : super(MypageState.initial()) {
    busSubscription = bus.subscribe((message) {
      if (message is ProfileUpdatedMessage) {
        add(GetMyInfo());
      }
    });

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
