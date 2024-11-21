part of 'auth_status_bloc.dart';

sealed class AuthStatusEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class CheckAuthStatus extends AuthStatusEvent {
  CheckAuthStatus();

  @override
  List<Object> get props => [];
}

final class MarkSignedIn extends AuthStatusEvent {
  MarkSignedIn();

  @override
  List<Object> get props => [];
}
