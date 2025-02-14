part of 'app_init_bloc.dart';

class AppInitState extends Equatable {
  final bool isFirstRun;
  final int selectedIndex;
  final InitFailure? failure;

  const AppInitState(
      {required this.isFirstRun,
      required this.selectedIndex,
      required this.failure});

  factory AppInitState.initial() =>
      const AppInitState(isFirstRun: true, selectedIndex: 0, failure: null);

  @override
  List<Object?> get props => [isFirstRun, selectedIndex];

  AppInitState copyWith({
    bool? isFirstRun,
    int? selectedIndex,
    InitFailure? failure,
  }) {
    return AppInitState(
      isFirstRun: isFirstRun ?? this.isFirstRun,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      failure: failure ?? this.failure,
    );
  }
}
