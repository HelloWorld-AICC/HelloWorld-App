import 'package:dartz/dartz.dart';
import 'package:hello_world_mvp/community/common/infrastructure/dtos/post_dto.dart';
import 'package:hello_world_mvp/fetch/failure.dart';

abstract class ICommunityInternalProvider {
  Future<Either<Failure, Unit>> createPost({
    required int categoryId,
    required PostDto postDto,
  });
}
