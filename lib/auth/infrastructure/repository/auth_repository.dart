// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hello_world_mvp/auth/domain/failure/auth_failure.dart';
import 'package:hello_world_mvp/auth/domain/model/token_set.dart';
import 'package:hello_world_mvp/auth/infrastructure/provider/interface/i_auth_internal_provider.dart';
import 'package:hello_world_mvp/auth/infrastructure/provider/interface/i_auth_local_provider.dart';
import 'package:hello_world_mvp/fetch/failure.dart';
import 'package:injectable/injectable.dart';

import 'package:hello_world_mvp/auth/domain/repository/i_auth_repository.dart';
import 'package:hello_world_mvp/auth/infrastructure/provider/interface/i_auth_external_provider.dart';
import '../dtos/token_dto.dart';

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
      print("idToken: $idToken");
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

  @override
  Future<Either<AuthFailure, Unit>> signOut() async {
    return (await authLocalProvider.deleteTokens()).fold(
      (f) => left(AuthFailure(message: f.message)),
      (_) => right(unit),
    );
  }

  @override
  Future<Either<AuthFailure, Unit>> refreshAccessTokenIfNeeded() async {
    final eitherTokenExpired = await authLocalProvider.checkIfTokenExpired();
    final tokenExpired = eitherTokenExpired.getOrElse(() => false);
    if (tokenExpired) {
      final rtkOrFailed = await authLocalProvider.getTokens();
      return rtkOrFailed.fold((f) => left(AuthFailure(message: f.message)),
          (rtk) async => await _refreshTokenWithGoogleSignIn(rtk.first.token));
    } else {
      return right(unit);
    }
  }

  Future<Either<AuthFailure, Unit>> _refreshTokenWithGoogleSignIn(
      String refreshToken) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? account = await googleSignIn.signInSilently();

    if (account == null) {
      return left(const AuthFailure(message: "GoogleSignInAccount가 null입니다."));
    }

    final GoogleSignInAuthentication googleAuth = await account.authentication;
    final Either<Failure, List<TokenDto>> result = await authInternalProvider
        .getTokenWithGoogleCode(googleAuth.idToken ?? '');

    return result.fold(
      (f) => left(AuthFailure(message: f.message)),
      (newTokenDtos) async => await _saveTokens(newTokenDtos),
    );
  }

  Future<Either<AuthFailure, Unit>> _saveTokens(
      List<TokenDto> tokenDtos) async {
    return (await authLocalProvider.saveTokens(tokenDtos)).fold(
      (f) => left(AuthFailure(message: f.message)),
      (_) => right(unit),
    );
  }
}
