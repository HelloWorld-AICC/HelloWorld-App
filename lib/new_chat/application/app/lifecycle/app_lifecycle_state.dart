part of 'app_lifecycle_bloc.dart';

class AppLifecycleState extends Equatable {
  final bool isResumed;

  const AppLifecycleState({required this.isResumed});

  factory AppLifecycleState.initial() =>
      const AppLifecycleState(isResumed: false);

  @override
  List<Object?> get props => [isResumed];

  AppLifecycleState copyWith({
    bool? isResumed,
  }) {
    return AppLifecycleState(
      isResumed: isResumed ?? this.isResumed,
    );
  }
}
