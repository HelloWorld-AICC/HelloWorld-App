// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hello_world_mvp/auth/domain/failure/auth_failure.dart';
import 'package:hello_world_mvp/auth/domain/model/token.dart';
import 'package:hello_world_mvp/auth/infrastructure/provider/interface/i_auth_internal_provider.dart';
import 'package:hello_world_mvp/auth/infrastructure/provider/interface/i_auth_local_provider.dart';
import 'package:injectable/injectable.dart';

import 'package:hello_world_mvp/auth/domain/repository/i_auth_repository.dart';
import 'package:hello_world_mvp/auth/infrastructure/provider/interface/i_auth_external_provider.dart';

@LazySingleton(as: IAuthRepository)
class AuthRepository implements IAuthRepository {
  final IAuthExternalProvider authExternalProvider;
  final IAuthInternalProvider authInternalProvider;
  final IAuthLocalProvider authLocalProvider;

  AuthRepository({
    required this.authExternalProvider,
    required this.authInternalProvider,
    required this.authLocalProvider,
  });

  @override
  Future<Either<AuthFailure, Unit>> getAuthCodeFromGoogle() async {
    return (await authExternalProvider.signInWithGoogle())
        .fold((f) => left(AuthFailure(message: f.message)), (result) async {
      if (result.serverAuthCode == null) {
        return left(const AuthFailure(message: "구글로 부터 받은 토큰이 null 입니다."));
      }

      if (result.serverAuthCode!.isEmpty) {
        return left(const AuthFailure(message: "구글로 부터 받은 토큰이 빈문자열 입니다."));
      }
      //
      return (await authInternalProvider
              .getTokenWithGoogleCode(result.serverAuthCode!))
          .fold((f) => left(AuthFailure(message: f.message)), (result) async {
        //
        return (await authLocalProvider.saveTokens(result))
            .fold((f) => left(AuthFailure(message: f.message)), (result) {
          return right(unit);
        });
      });
    });
  }
}
