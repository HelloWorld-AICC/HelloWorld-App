part of 'app_lifecycle_bloc.dart';

class CustomAppLifecycleState extends Equatable {
  final bool isResumed;

  const CustomAppLifecycleState({required this.isResumed});

  factory CustomAppLifecycleState.initial() =>
      const CustomAppLifecycleState(isResumed: false);

  @override
  List<Object?> get props => [isResumed];

  CustomAppLifecycleState copyWith({
    bool? isResumed,
  }) {
    return CustomAppLifecycleState(
      isResumed: isResumed ?? this.isResumed,
    );
  }
}
