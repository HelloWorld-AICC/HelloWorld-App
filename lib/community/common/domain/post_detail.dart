import 'package:equatable/equatable.dart';
import 'package:hello_world_mvp/community/common/domain/comment.dart';
import 'package:hello_world_mvp/core/value_objects.dart';

class PostDetail extends Equatable {
  final StringVO title;
  final StringVO content;
  final StringVO createAt;
  final ListVO<StringVO> fileList;
  final ListVO<Comment> commentList;

  const PostDetail({
    required this.title,
    required this.content,
    required this.createAt,
    required this.fileList,
    required this.commentList,
  });

  @override
  List<Object?> get props => [
        title,
        content,
        createAt,
        fileList,
        commentList,
      ];
}
