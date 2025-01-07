import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_init_event.dart';

part 'app_init_state.dart';

@Injectable()
class AppInitBloc extends Bloc<AppInitEvent, AppInitState> {
  AppInitBloc() : super(AppInitState.initial()) {
    on<MarkAppRunnedBefore>(_onMarkAppRunnedBefore);
    on<MarkSplashDone>(_onCheckSplashDone);
    on<MarkLanguageSelected>(_onCheckLanguageSelected);
  }

  Future<void> _onMarkAppRunnedBefore(
    MarkAppRunnedBefore event,
    Emitter<AppInitState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstRun', false);
  }

  Future<void> _onCheckSplashDone(
    MarkSplashDone event,
    Emitter<AppInitState> emit,
  ) async {
    emit((state.copyWith(isSplashComplete: true)));
  }

  Future<void> _onCheckLanguageSelected(
    MarkLanguageSelected event,
    Emitter<AppInitState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstRun', false);
    emit((state.copyWith(isLanguageSelected: true, isFirstRun: false)));
  }
}
