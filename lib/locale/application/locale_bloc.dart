import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/auth/domain/failure/auth_failure.dart';
import 'package:hello_world_mvp/auth/domain/repository/i_token_repository.dart';

import 'package:injectable/injectable.dart';

part 'locale_event.dart';
part 'locale_state.dart';

@injectable
class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  final ITokenRepository tokenRepository;

  LocaleBloc({required this.tokenRepository}) : super(LocaleState.initial()) {
    on<SetLocale>((event, emit) async {
      emit(state.copyWith(locale: event.locale));
    });
  }
}
