import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hello_world_mvp/fetch/failure.dart';
import 'package:hello_world_mvp/mypage/menu/infrastructure/dtos/my_info_dto.dart';

abstract class IMypageInternalProvider {
  Future<Either<Failure, MyInfoDto>> getMyInfo();

  Future<Either<Failure, Unit>> modifyMyProfile(File? file, String? nickname);
}
