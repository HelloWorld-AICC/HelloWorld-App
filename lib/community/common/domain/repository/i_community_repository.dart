import 'package:dartz/dartz.dart';
import 'package:hello_world_mvp/community/common/domain/community_failure.dart';
import 'package:hello_world_mvp/community/common/domain/creat_post.dart';
import 'package:hello_world_mvp/community/common/domain/post_list.dart';
import 'package:hello_world_mvp/fetch/failure.dart';

import '../post_detail.dart';

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

  Future<Either<CommunityFailure, PostDetail>> getPostDetail({
    required int page,
    required int pageSize,
    required int categoryId,
    required int postId,
  });

  Future<Either<Failure, Unit>> writeComment({
    required int postId,
    required String content,
  });
}
