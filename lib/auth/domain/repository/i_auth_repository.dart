import 'package:dartz/dartz.dart';
import 'package:hello_world_mvp/auth/domain/failure/auth_failure.dart';

abstract class IAuthRepository {
  Future<Either<AuthFailure, Unit>> getAuthCodeFromGoogle();
}
