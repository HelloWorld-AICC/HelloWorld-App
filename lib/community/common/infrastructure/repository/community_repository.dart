import 'package:dartz/dartz.dart';
import 'package:hello_world_mvp/community/common/domain/post.dart';
import 'package:hello_world_mvp/community/common/domain/repository/i_community_repository.dart';
import 'package:hello_world_mvp/community/common/infrastructure/dtos/post_dto.dart';
import 'package:hello_world_mvp/community/common/infrastructure/provider/community_internal_provider.dart';
import 'package:hello_world_mvp/community/common/infrastructure/provider/interface/i_community_internal_provider.dart';
import 'package:hello_world_mvp/fetch/failure.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ICommunityRepository)
class CommunityRepository implements ICommunityRepository {
  final ICommunityInternalProvider _internalProvider;

  CommunityRepository(this._internalProvider);

  @override
  Future<Either<Failure, Unit>> createPost({
    required int categoryId,
    required Post post,
  }) async {
    final postDto = PostDto.fromDomain(post);
    final failureOrTokens = await _internalProvider.createPost(
      categoryId: categoryId,
      postDto: postDto,
    );

    return failureOrTokens.fold((f) => left(f), (result) => right(unit));
  }
}
