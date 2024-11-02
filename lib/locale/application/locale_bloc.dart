import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:injectable/injectable.dart';

part 'locale_event.dart';

part 'locale_state.dart';

@injectable
class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc() : super(LocaleState.initial()) {
    on<SetLocale>((event, emit) async {
      emit(state.copyWith(locale: event.locale, selectedIndex: event.index));
    });
  }
}
