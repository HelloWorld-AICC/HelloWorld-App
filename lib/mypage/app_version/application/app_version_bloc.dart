import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/bus/bus.dart';
import 'package:hello_world_mvp/bus/bus_message.dart';
import 'package:hello_world_mvp/mypage/common/application/mypage_messages.dart';
import 'package:hello_world_mvp/mypage/common/domain/failure/app_version_failure.dart';
import 'package:hello_world_mvp/mypage/common/domain/repository/i_app_version_repository.dart';
import 'package:hello_world_mvp/mypage/common/domain/repository/i_mypage_repository.dart';

import 'package:injectable/injectable.dart';

part 'app_version_event.dart';
part 'app_version_state.dart';

@injectable
class AppVersionBloc extends Bloc<AppVersionEvent, AppVersionState> {
  final IAppVersionRepository appVersionRepository;

  @override
  Future<void> close() {
    return super.close();
  }

  AppVersionBloc({required this.appVersionRepository})
      : super(AppVersionState.initial()) {
    on<GetAppVersion>((event, emit) async {
      emit(AppVersionState.initial().copyWith(isLoading: true));
      final appVersionOrFailure = await appVersionRepository.getAppVersion();

      emit(appVersionOrFailure.fold((f) {
        return state.copyWith(failure: f, isLoading: false);
      }, (appVersion) {
        return state.copyWith(appVersion: appVersion, isLoading: false);
      }));
    });
  }
}
