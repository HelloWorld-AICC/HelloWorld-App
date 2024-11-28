// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hello_world_mvp/auth/domain/failure/auth_failure.dart';
import 'package:hello_world_mvp/auth/domain/model/token_set.dart';
import 'package:hello_world_mvp/auth/domain/repository/i_token_repository.dart';
import 'package:hello_world_mvp/auth/infrastructure/provider/interface/i_auth_local_provider.dart';
import 'package:hello_world_mvp/mypage/common/domain/failure/mypage_failure.dart';
import 'package:hello_world_mvp/mypage/common/domain/model/my_info.dart';
import 'package:hello_world_mvp/mypage/common/domain/repository/i_mypage_repository.dart';

import 'package:hello_world_mvp/mypage/common/infrastructure/provider/interface/i_mypage_internal_provider.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IMypageRepository)
class MypageRepository implements IMypageRepository {
  final IMypageInternalProvider mypageProvider;

  MypageRepository({
    required this.mypageProvider,
  });

  @override
  Future<Either<MypageFailure, MyInfo>> getMyInfo() async {
    final myInfoOrFailure = await mypageProvider.getMyInfo();

    return myInfoOrFailure.fold((f) => left(MypageFailure(message: f.message)),
        (result) {
      return right(result.toDomain());
    });
  }

  @override
  Future<Either<MypageFailure, Unit>> setProfile(
      File? file, String? nickname) async {
    final myInfoOrFailure =
        await mypageProvider.modifyMyProfile(file, nickname);

    return myInfoOrFailure.fold((f) => left(MypageFailure(message: f.message)),
        (result) {
      return right(unit);
    });
  }
}
