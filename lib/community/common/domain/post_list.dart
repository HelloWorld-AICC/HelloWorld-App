import 'package:equatable/equatable.dart';
import 'package:hello_world_mvp/community/common/domain/post.dart';

class PostList extends Equatable {
  final List<Post> posts;

  const PostList({required this.posts});

  @override
  List<Object?> get props => [posts];
}
