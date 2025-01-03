import 'package:equatable/equatable.dart';
import 'package:hello_world_mvp/core/value_objects.dart';

class Post extends Equatable {
  final IdVO postId;
  final StringVO title;
  final DateVO createdAt;
  final IntVO commentNum;
  final StringVO? imageUrl;

  const Post(
      {required this.postId,
      required this.title,
      required this.createdAt,
      required this.commentNum,
      this.imageUrl});

  @override
  List<Object?> get props => [
        postId,
        title,
        createdAt,
        commentNum,
        imageUrl,
      ];
}
