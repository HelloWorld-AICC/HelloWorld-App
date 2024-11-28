import 'package:dartz/dartz.dart';
import 'package:hello_world_mvp/fetch/failure.dart';
import 'package:hello_world_mvp/fetch/local_failure.dart';
import 'package:hello_world_mvp/mypage/common/infrastructure/provider/interface/i_app_version_local_provider.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

@LazySingleton(as: IAppVersionLocalProvider)
class AppVersionLocalProvider implements IAppVersionLocalProvider {
  @override
  Future<Either<Failure, String>> getAppVersion() async {
    late PackageInfo packageInfo;

    try {
      packageInfo = await PackageInfo.fromPlatform();
    } catch (_) {
      return left(const LocalFailure(message: "버전 정보를 가져오는데 실패했습니다."));
    }

    return right(packageInfo.version);
  }
}
