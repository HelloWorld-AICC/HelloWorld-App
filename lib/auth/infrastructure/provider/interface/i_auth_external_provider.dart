import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hello_world_mvp/fetch/failure.dart';

abstract class IAuthExternalProvider {
  Future<Either<Failure, GoogleSignInAccount>> signInWithGoogle();
}
