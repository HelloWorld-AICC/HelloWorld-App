import 'package:dartz/dartz.dart';
import 'package:hello_world_mvp/mypage/profile/domain/failure/mypage_failure.dart';
import 'package:hello_world_mvp/mypage/profile/domain/model/my_info.dart';

abstract class IMypageRepository {
  Future<Either<MypageFailure, MyInfo>> getMyInfo();
}
