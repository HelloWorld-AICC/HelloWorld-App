// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:hello_world_mvp/auth/domain/failure/auth_failure.dart';
import 'package:hello_world_mvp/auth/domain/model/token_set.dart';
import 'package:hello_world_mvp/auth/domain/repository/i_token_repository.dart';
import 'package:hello_world_mvp/auth/infrastructure/provider/interface/i_auth_local_provider.dart';
import 'package:injectable/injectable.dart';

// 순환참조를 막기 위해 IAuthRepository와 분리한다.
@LazySingleton(as: ITokenRepository)
class TokenRepository implements ITokenRepository {
  final IAuthLocalProvider authLocalProvider;

  TokenRepository({
    required this.authLocalProvider,
  });

  @override
  Future<Either<AuthFailure, TokenSet>> getTokens() async {
    return (await authLocalProvider.getTokens()).fold((f) {
      return left(const AuthFailure(message: ""));
    }, (tokenList) {
      return right(
          TokenSet(tokens: tokenList.map((e) => e.toDomain()).toList()));
    });
  }
}
