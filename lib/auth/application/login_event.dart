part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class SignInWithGoogle extends LoginEvent {
  SignInWithGoogle();

  @override
  List<Object> get props => [];
}
