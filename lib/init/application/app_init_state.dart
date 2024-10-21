part of 'app_init_bloc.dart';

class AppInitState extends Equatable {
  final bool isFirstRun;

  const AppInitState({required this.isFirstRun});

  factory AppInitState.initial() => const AppInitState(isFirstRun: true);

  @override
  List<Object?> get props => [isFirstRun];

  AppInitState copyWith({
    bool? isFirstRun,
  }) {
    return AppInitState(
      isFirstRun: isFirstRun ?? this.isFirstRun,
    );
  }
}
