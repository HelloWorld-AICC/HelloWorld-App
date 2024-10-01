// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hello_world_mvp/auth/domain/failure/auth_failure.dart';
import 'package:hello_world_mvp/auth/domain/model/token_set.dart';
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
      final idToken = (await result.authentication).idToken;

      if (idToken == null) {
        return left(AuthFailure(message: tr("auth_account_is_null")));
      }

      if (idToken.isEmpty) {
        return left(const EmptyIdTokenFalure());
      }
      //
      return (await authInternalProvider.getTokenWithGoogleCode(idToken))
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
