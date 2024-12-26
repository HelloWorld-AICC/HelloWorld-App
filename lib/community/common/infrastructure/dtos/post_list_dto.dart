import 'package:hello_world_mvp/community/common/domain/post_list.dart';
import 'package:hello_world_mvp/community/common/infrastructure/dtos/post_dto.dart';

class PostListDto {
  final List<PostDto> posts;

  PostListDto({required this.posts});

  PostList toDomain() {
    return PostList(posts: posts.map((e) => e.toDomain()).toList());
  }

  static PostListDto fromDomain(PostList domainPosts) {
    return PostListDto(
      posts: domainPosts.posts.map((e) => PostDto.fromDomain(e)).toList(),
    );
  }

  factory PostListDto.fromJson(Map<String, dynamic> json) {
    return PostListDto(
      posts: (json['posts'] as List).map((e) => PostDto.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'posts': posts.map((e) => e.toJson()).toList(),
    };
  }
}
