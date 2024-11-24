import 'package:dartz/dartz.dart';
import 'package:hello_world_mvp/mypage/common/domain/failure/app_version_failure.dart';

abstract class IAppVersionRepository {
  Future<Either<AppVersionFailure, String>> getAppVersion();
}
