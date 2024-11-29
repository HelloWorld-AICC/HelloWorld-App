import 'package:dartz/dartz.dart';
import 'package:hello_world_mvp/community/common/domain/post.dart';
import 'package:hello_world_mvp/fetch/failure.dart';

abstract class ICommunityRepository {
  Future<Either<Failure, Unit>> createPost({
    required int categoryId,
    required Post post,
  });
}
