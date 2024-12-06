import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hello_world_mvp/auth/infrastructure/provider/interface/i_auth_external_provider.dart';
import 'package:hello_world_mvp/fetch/external_failure.dart';
import 'package:hello_world_mvp/fetch/failure.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IAuthExternalProvider)
class AuthExternalProvider implements IAuthExternalProvider {
  @override
  Future<Either<Failure, GoogleSignInAccount>> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: <String>['email'],
    );

    late GoogleSignInAccount? signInAccount;

    try {
      await googleSignIn.signOut();
      signInAccount = await googleSignIn.signIn();
    } catch (error) {
      return left(ExternalFailure(message: error.toString()));
    }

    if (signInAccount == null) {
      return left(
          const ExternalFailure(message: "GoogleSignInAccount가 null입니다."));
    }

    return right(signInAccount);
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: <String>['email'],
    );

    try {
      await googleSignIn.signOut();
    } catch (error) {
      return left(ExternalFailure(message: error.toString()));
    }

    return right(unit);
  }
}
