import 'package:dartz/dartz.dart';
import 'package:hello_world_mvp/auth/domain/failure/auth_failure.dart';
import 'package:hello_world_mvp/auth/domain/model/token_set.dart';

abstract class ITokenRepository {
  Future<Either<AuthFailure, TokenSet>> getTokens();
}
