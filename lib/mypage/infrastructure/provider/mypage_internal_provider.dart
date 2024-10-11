// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:hello_world_mvp/mypage/infrastructure/dtos/my_info_dto.dart';
import 'package:hello_world_mvp/mypage/infrastructure/provider/interface/i_mypage_internal_provider.dart';
import 'package:injectable/injectable.dart';

import 'package:hello_world_mvp/fetch/failure.dart';
import 'package:hello_world_mvp/fetch/fetch_service.dart';

@LazySingleton(as: IMypageInternalProvider)
class MypageInternalProvider implements IMypageInternalProvider {
  final FetchService _fetchService;
  MypageInternalProvider(this._fetchService);

  @override
  Future<Either<Failure, MyInfoDto>> getMyInfo() async {
    final failureOrTokens = await _fetchService.request(
      pathPrefix: "",
      path: "/myPage/",
      method: HttpMethod.get,
    );

    return failureOrTokens.fold((f) {
      return left(f);
    }, (response) {
      return right(MyInfoDto.fromJson(response.result));
    });
  }
}
