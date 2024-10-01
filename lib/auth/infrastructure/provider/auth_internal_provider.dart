// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:hello_world_mvp/auth/infrastructure/dtos/token_dto.dart';
import 'package:hello_world_mvp/auth/infrastructure/provider/interface/i_auth_internal_provider.dart';
import 'package:hello_world_mvp/fetch/failure.dart';
import 'package:hello_world_mvp/fetch/fetch_service.dart';

@LazySingleton(as: IAuthInternalProvider)
class AuthInternalProvider implements IAuthInternalProvider {
  final FetchService _fetchService;
  AuthInternalProvider(this._fetchService);

  @override
  Future<Either<Failure, List<TokenDto>>> getTokenWithGoogleCode(
      String code) async {
    final failureOrTokens = await _fetchService.request(
      pathPrefix: "/api/v1",
      path: "/google/login",
      method: HttpMethod.get,
      queryParams: {
        "token": code,
      },
    );

    return failureOrTokens.fold((f) {
      return left(f);
    }, (response) {
      final result = response.result['tokenList'] as List<dynamic>;
      return right(result.map((e) => TokenDto.fromJson(e)).toList());
    });
  }
}
