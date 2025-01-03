import 'package:dartz/dartz.dart';
import 'package:hello_world_mvp/community/common/domain/community_failure.dart';
import 'package:hello_world_mvp/community/common/domain/creat_post.dart';
import 'package:hello_world_mvp/community/common/domain/post_list.dart';
import 'package:hello_world_mvp/community/common/domain/repository/i_community_repository.dart';
import 'package:hello_world_mvp/community/common/infrastructure/dtos/create_post_dto.dart';
import 'package:hello_world_mvp/community/common/infrastructure/provider/interface/i_community_internal_provider.dart';
import 'package:hello_world_mvp/fetch/failure.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ICommunityRepository)
class CommunityRepository implements ICommunityRepository {
  final ICommunityInternalProvider _internalProvider;

  CommunityRepository(this._internalProvider);

  @override
  Future<Either<CommunityFailure, PostList>> getPosts({
    required int categoryId,
    required int page,
    required int pageSize,
  }) async {
    final failureOrTokens = await _internalProvider.getPosts(
      categoryId: categoryId,
      page: page,
      pageSize: pageSize,
    );

    return failureOrTokens.fold(
        (f) => left(CommunityFailure(message: f.message)),
        (result) => right(result.toDomain()));
  }

  @override
  Future<Either<Failure, Unit>> createPost({
    required int categoryId,
    required CreatePost post,
  }) async {
    final postDto = CreatePostDto.fromDomain(post);
    final failureOrTokens = await _internalProvider.createPost(
      categoryId: categoryId,
      postDto: postDto,
    );

    return failureOrTokens.fold((f) => left(f), (result) => right(unit));
  }
}
