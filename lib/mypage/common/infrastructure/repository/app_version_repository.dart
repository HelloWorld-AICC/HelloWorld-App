// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hello_world_mvp/auth/domain/failure/auth_failure.dart';
import 'package:hello_world_mvp/auth/domain/model/token_set.dart';
import 'package:hello_world_mvp/auth/domain/repository/i_token_repository.dart';
import 'package:hello_world_mvp/auth/infrastructure/provider/interface/i_auth_local_provider.dart';
import 'package:hello_world_mvp/mypage/common/domain/failure/app_version_failure.dart';
import 'package:hello_world_mvp/mypage/common/domain/failure/mypage_failure.dart';
import 'package:hello_world_mvp/mypage/common/domain/model/my_info.dart';
import 'package:hello_world_mvp/mypage/common/domain/repository/i_app_version_repository.dart';
import 'package:hello_world_mvp/mypage/common/domain/repository/i_mypage_repository.dart';
import 'package:hello_world_mvp/mypage/common/infrastructure/provider/interface/i_app_version_local_provider.dart';

import 'package:hello_world_mvp/mypage/common/infrastructure/provider/interface/i_mypage_internal_provider.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IAppVersionRepository)
class AppVersionRepository implements IAppVersionRepository {
  final IAppVersionLocalProvider appVersionProvider;

  AppVersionRepository({required this.appVersionProvider});

  @override
  Future<Either<AppVersionFailure, String>> getAppVersion() async {
    return (await appVersionProvider.getAppVersion())
        .fold((f) => left(AppVersionFailure(message: f.message)), (r) {
      return right(r);
    });
  }
}
