import 'package:dartz/dartz.dart';
import 'package:hello_world_mvp/fetch/failure.dart';

abstract class IAppVersionLocalProvider {
  Future<Either<Failure, String>> getAppVersion();
}
