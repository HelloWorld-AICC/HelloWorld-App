part of 'auth_status_bloc.dart';

class AuthStatusState extends Equatable {
  final bool? isSignedIn;
  final bool isLoading;
  final bool isFirstRun;

  const AuthStatusState({
    required this.isSignedIn,
    required this.isLoading,
    required this.isFirstRun,
  });

  factory AuthStatusState.initial() {
    return const AuthStatusState(
      isSignedIn: null,
      isLoading: true,
      isFirstRun: true,
    );
  }

  AuthStatusState copyWith({
    bool? isSignedIn,
    bool? isLoading,
    bool? isFirstRun,
  }) {
    return AuthStatusState(
      isSignedIn: isSignedIn ?? this.isSignedIn,
      isLoading: isLoading ?? this.isLoading,
      isFirstRun: isFirstRun ?? this.isFirstRun,
    );
  }

  @override
  List<Object?> get props => [isSignedIn, isLoading, isFirstRun];
}
