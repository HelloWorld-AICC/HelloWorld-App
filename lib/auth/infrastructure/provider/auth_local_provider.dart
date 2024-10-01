// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:hello_world_mvp/auth/infrastructure/dtos/token_dto.dart';
import 'package:hello_world_mvp/auth/infrastructure/provider/interface/i_auth_local_provider.dart';
import 'package:hello_world_mvp/local_storage/local_storage_failure.dart';
import 'package:hello_world_mvp/local_storage/local_storage_service.dart';

@LazySingleton(as: IAuthLocalProvider)
class AuthLocalProvier implements IAuthLocalProvider {
  final LocalStorageService service;
  AuthLocalProvier({
    required this.service,
  });

  static const userTokensKey = "userTokens";

  @override
  Future<Either<LocalStorageFailure, Unit>> saveTokens(
      List<TokenDto> tokens) async {
    final successOrFailure = await service.write(
        userTokensKey, {"tokens": tokens.map((e) => e.toJson()).toList()});

    return successOrFailure.fold((f) {
      return left(LocalStorageFailure(message: f.message));
    }, (result) {
      return right(unit);
    });
  }

  @override
  Future<Either<LocalStorageFailure, List<TokenDto>>> getTokens() async {
    final tokensOrFailure = await service.read(userTokensKey);

    return tokensOrFailure.fold((f) {
      return left(LocalStorageFailure(message: f.message));
    }, (result) {
      return right((result as List).map((e) => TokenDto.fromJson(e)).toList());
    });
  }
}
