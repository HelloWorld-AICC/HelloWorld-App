part of 'post_detail_bloc.dart';

sealed class PostDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class PostDetailFetched extends PostDetailEvent {
  final int postId;
  final int categoryId;

  PostDetailFetched({required this.postId, required this.categoryId});

  @override
  List<Object> get props => [postId, categoryId];
}

final class PostDetailCommentAdded extends PostDetailEvent {
  final String comment;
  final int postId;
  final int categoryId;

  PostDetailCommentAdded(
      {required this.comment, required this.postId, required this.categoryId});

  @override
  List<Object> get props => [comment];
}
