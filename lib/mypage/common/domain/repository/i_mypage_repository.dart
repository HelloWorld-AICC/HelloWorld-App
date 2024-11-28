import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hello_world_mvp/mypage/common/domain/failure/mypage_failure.dart';
import 'package:hello_world_mvp/mypage/common/domain/model/my_info.dart';

abstract class IMypageRepository {
  Future<Either<MypageFailure, MyInfo>> getMyInfo();

  Future<Either<MypageFailure, Unit>> setProfile(File? file, String? nickname);
}
