import 'package:dartz/dartz.dart';
import 'package:hello_world_mvp/community/common/infrastructure/dtos/create_post_dto.dart';
import 'package:hello_world_mvp/community/common/infrastructure/dtos/post_detail_dto.dart';
import 'package:hello_world_mvp/community/common/infrastructure/dtos/post_list_dto.dart';
import 'package:hello_world_mvp/fetch/failure.dart';

abstract class ICommunityInternalProvider {
  Future<Either<Failure, PostListDto>> getPosts({
    required int categoryId,
    required int page,
    required int pageSize,
  });

  Future<Either<Failure, Unit>> createPost({
    required int categoryId,
    required CreatePostDto postDto,
  });

  Future<Either<Failure, PostDetailDto>> getPostDetail({
    required int categoryId,
    required int postId,
  });
}
