// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signout_bloc.dart';

class SignOutState extends Equatable {
  final bool? isSignedOut;
  final AuthFailure? failure;
  final bool isLoading;

  const SignOutState({
    required this.isSignedOut,
    required this.failure,
    required this.isLoading,
  });

  factory SignOutState.initial() =>
      const SignOutState(isSignedOut: null, failure: null, isLoading: false);

  @override
  List<Object?> get props => [isSignedOut, failure, isLoading];

  SignOutState copyWith({
    bool? isSignedOut,
    AuthFailure? failure,
    bool? isLoading,
  }) {
    return SignOutState(
      isSignedOut: isSignedOut ?? this.isSignedOut,
      failure: failure ?? this.failure,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
