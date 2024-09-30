// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool? succeeded;
  final AuthFailure? failure;

  const LoginState({required this.succeeded, required this.failure});

  factory LoginState.initial() =>
      const LoginState(succeeded: null, failure: null);

  @override
  List<Object?> get props => [succeeded, failure];

  LoginState copyWith({bool? succeeded, AuthFailure? failure}) {
    return LoginState(
      succeeded: succeeded ?? this.succeeded,
      failure: failure ?? this.failure,
    );
  }
}
