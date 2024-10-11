import 'package:dartz/dartz.dart';
import 'package:hello_world_mvp/mypage/domain/failure/mypage_failure.dart';
import 'package:hello_world_mvp/mypage/domain/model/my_info.dart';

abstract class IMypageRepository {
  Future<Either<MypageFailure, MyInfo>> getMyInfo();
}
