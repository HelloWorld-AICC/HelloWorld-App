import 'package:dartz/dartz.dart';
import 'package:hello_world_mvp/auth/domain/failure/auth_failure.dart';

import '../../infrastructure/dtos/token_dto.dart';

abstract class IAuthRepository {
  Future<Either<AuthFailure, Unit>> getAuthCodeFromGoogle();

  Future<Either<AuthFailure, Unit>> signOut();

  Future<Either<AuthFailure, Unit>> refreshAccessTokenIfNeeded(
      List<TokenDto> tokenDtos);
}
