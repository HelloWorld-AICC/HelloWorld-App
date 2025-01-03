import 'package:equatable/equatable.dart';
import 'package:hello_world_mvp/community/common/domain/comment.dart';
import 'package:hello_world_mvp/core/value_objects.dart';

class PostDetail extends Equatable {
  final StringVO title;
  final StringVO content;
  final StringVO createAt;
  final ListVO<StringVO> fileList;
  final ListVO<Comment> commentList;
}
