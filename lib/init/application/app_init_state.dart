part of 'app_init_bloc.dart';

class AppInitState extends Equatable {
  final bool isFirstRun;
  final bool isSplashComplete;
  final bool isLanguageSelected;

  const AppInitState(
      {required this.isFirstRun,
      required this.isSplashComplete,
      required this.isLanguageSelected});

  factory AppInitState.initial() => const AppInitState(
      isFirstRun: true, isSplashComplete: false, isLanguageSelected: false);

  @override
  List<Object?> get props => [isFirstRun, isSplashComplete, isLanguageSelected];

  AppInitState copyWith({
    bool? isFirstRun,
    bool? isSplashComplete,
    bool? isLanguageSelected,
  }) {
    return AppInitState(
      isFirstRun: isFirstRun ?? this.isFirstRun,
      isSplashComplete: isSplashComplete ?? this.isSplashComplete,
      isLanguageSelected: isLanguageSelected ?? this.isLanguageSelected,
    );
  }
}
