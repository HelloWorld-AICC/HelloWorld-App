import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_init_event.dart';

part 'app_init_state.dart';

@Injectable()
class AppInitBloc extends Bloc<AppInitEvent, AppInitState> {
  AppInitBloc() : super(AppInitState.initial()) {
    on<CheckAppFirstRun>(_onCheckAppFirstRun);
    on<MarkSplashDone>(_onCheckSplashDone);
  }

  Future<void> _onCheckAppFirstRun(
    CheckAppFirstRun event,
    Emitter<AppInitState> emit,
  ) async {
    print("Checking if app has run before");
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstRun', false);
    emit(state.copyWith(isFirstRun: false));
  }

  Future<void> _onCheckSplashDone(
    MarkSplashDone event,
    Emitter<AppInitState> emit,
  ) async {
    emit((state.copyWith(isSplashComplete: true)));
  }
}
