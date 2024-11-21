import 'package:dartz/dartz.dart';
import 'package:hello_world_mvp/auth/infrastructure/dtos/token_dto.dart';
import 'package:hello_world_mvp/fetch/failure.dart';

abstract class IAuthInternalProvider {
  Future<Either<Failure, List<TokenDto>>> getTokenWithGoogleCode(String code);

  Future<Either<Failure, Unit>> withdraw();
}
