import 'package:dartz/dartz.dart';
import 'package:hello_world_mvp/community/common/domain/community_failure.dart';
import 'package:hello_world_mvp/community/common/domain/creat_post.dart';
import 'package:hello_world_mvp/community/common/domain/post_list.dart';
import 'package:hello_world_mvp/fetch/failure.dart';

abstract class ICommunityRepository {
  Future<Either<CommunityFailure, PostList>> getPosts({
    required int categoryId,
    required int page,
    required int pageSize,
  });

  Future<Either<Failure, Unit>> createPost({
    required int categoryId,
    required CreatePost post,
  });
}
