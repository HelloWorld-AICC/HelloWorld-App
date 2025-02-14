import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/core/value_objects.dart';
import 'package:hello_world_mvp/init/domain/failure/init_failure.dart';
import 'package:hello_world_mvp/init/infrastructure/repository/i_init_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_init_event.dart';

part 'app_init_state.dart';

@Injectable()
class AppInitBloc extends Bloc<AppInitEvent, AppInitState> {
  final IInitRepository iInitRepository;

  AppInitBloc({required this.iInitRepository}) : super(AppInitState.initial()) {
    on<MarkAppRunnedBefore>(_onMarkAppRunnedBefore);
    on<StoreSelectedLanguage>(_onStoreSelectedLanguage);
    on<SendUserLanguage>(_onSendUserLanguage);
  }

  Future<void> _onMarkAppRunnedBefore(
    MarkAppRunnedBefore event,
    Emitter<AppInitState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstRun', false);
  }

  Future<void> _onStoreSelectedLanguage(
    StoreSelectedLanguage event,
    Emitter<AppInitState> emit,
  ) async {
    emit(state.copyWith(selectedIndex: event.selectedIndex));
  }

  Future<bool> _onSendUserLanguage(
    SendUserLanguage event,
    Emitter<AppInitState> emit,
  ) async {
    iInitRepository.sendUserLanguage(languageId: event.languageId);
    var temp = await iInitRepository.getUserLanguage();
    if (temp.isLeft()) {
      emit((state.copyWith(failure: InitSendUserLanguageFailure())));
    }

    String languageFromServer = "English";
    var temp2 = await iInitRepository.getUserLanguage();
    temp2.fold(
      (l) => emit(state.copyWith(failure: InitGetUserLanguageFailure())),
      (r) => languageFromServer = r.value as String,
    );

    Map<String, int> languages = {
      "English": 1,
      "Korean": 2,
      "Japanese": 3,
      "Chinese": 4,
      "Vietnamese": 5
    };
    if (languages[languageFromServer] != event.languageId) {
      return false;
    }
    return true;
  }
}
