import 'package:dartz/dartz.dart';
import 'package:hello_world_mvp/community/common/infrastructure/dtos/create_post_dto.dart';
import 'package:hello_world_mvp/community/common/infrastructure/dtos/post_detail_dto.dart';
import 'package:hello_world_mvp/community/common/infrastructure/dtos/post_list_dto.dart';
import 'package:hello_world_mvp/community/common/infrastructure/provider/interface/i_community_internal_provider.dart';
import 'package:hello_world_mvp/fetch/failure.dart';
import 'package:hello_world_mvp/fetch/fetch_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ICommunityInternalProvider)
class CommunityInternalProvider implements ICommunityInternalProvider {
  final FetchService _fetchService;

  CommunityInternalProvider(this._fetchService);

  @override
  Future<Either<Failure, PostListDto>> getPosts({
    required int categoryId,
    required int page,
    required int pageSize,
  }) async {
    final failureOrTokens = await _fetchService.request(
      pathPrefix: "",
      path: "/community/$categoryId/list",
      method: HttpMethod.get,
      queryParams: {
        "page": page.toString(),
        "size": pageSize.toString(),
      },
    );

    return failureOrTokens.fold((f) {
      return left(f);
    }, (response) {
      return right(PostListDto.fromJson(response.result));
    });
  }

  @override
  Future<Either<Failure, Unit>> createPost({
    required int categoryId,
    required CreatePostDto postDto,
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

  @override
  Future<Either<Failure, PostDetailDto>> getPostDetail({
    required int categoryId,
    required int postId,
  }) async {
    final failureOrTokens = await _fetchService.request(
        pathPrefix: "",
        path: "/community/$categoryId/detail/$postId",
        method: HttpMethod.get);

    return failureOrTokens.fold((f) {
      return left(f);
    }, (result) {
      final PostDetailDto postDetailDto = PostDetailDto.fromJson(result.result);

      return right(postDetailDto);
    });
  }
}
