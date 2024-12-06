part of 'app_init_bloc.dart';

class AppInitState extends Equatable {
  final bool isFirstRun;
  final bool isSplashComplete;

  const AppInitState(
      {required this.isFirstRun, required this.isSplashComplete});

  factory AppInitState.initial() =>
      const AppInitState(isFirstRun: true, isSplashComplete: false);

  @override
  List<Object?> get props => [isFirstRun, isSplashComplete];

  AppInitState copyWith({
    bool? isFirstRun,
    bool? isSplashComplete,
  }) {
    return AppInitState(
      isFirstRun: isFirstRun ?? this.isFirstRun,
      isSplashComplete: isSplashComplete ?? this.isSplashComplete,
    );
  }
}
