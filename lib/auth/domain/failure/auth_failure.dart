import 'package:hello_world_mvp/fetch/failure.dart';

class AuthFailure extends Failure {
  const AuthFailure({required super.message});
}

class EmptyIdTokenFalure extends AuthFailure {
  const EmptyIdTokenFalure() : super(message: "");
}
