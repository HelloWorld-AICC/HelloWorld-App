import 'package:dartz/dartz.dart';
import 'package:hello_world_mvp/community/common/infrastructure/dtos/post_dto.dart';
import 'package:hello_world_mvp/community/common/infrastructure/provider/interface/i_community_internal_provider.dart';
import 'package:hello_world_mvp/fetch/failure.dart';
import 'package:hello_world_mvp/fetch/fetch_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ICommunityInternalProvider)
class CommunityInternalProvider implements ICommunityInternalProvider {
  final FetchService _fetchService;

  CommunityInternalProvider(this._fetchService);

  @override
  Future<Either<Failure, Unit>> createPost({
    required int categoryId,
    required PostDto postDto,
  }) async {
    final failureOrTokens = await _fetchService.request(
      pathPrefix: "",
      path: "/community/$categoryId/create",
      method: HttpMethod.file,
      files: postDto.medias,
      bodyParam: {
        "title": postDto.title,
        "content": postDto.body,
      },
    );

    return failureOrTokens.fold((f) {
      return left(f);
    }, (result) {
      return right(unit);
    });
  }
}
