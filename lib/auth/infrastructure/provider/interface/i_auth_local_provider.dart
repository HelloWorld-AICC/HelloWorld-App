import 'package:dartz/dartz.dart';
import 'package:hello_world_mvp/auth/infrastructure/dtos/token_dto.dart';
import 'package:hello_world_mvp/local_storage/local_storage_failure.dart';

abstract class IAuthLocalProvider {
  Future<Either<LocalStorageFailure, Unit>> saveTokens(List<TokenDto> tokens);

  Future<Either<LocalStorageFailure, Unit>> deleteTokens();

  Future<Either<LocalStorageFailure, List<TokenDto>>> getTokens();

  Future<Either<LocalStorageFailure, bool>> checkIfTokenExpired();
}
