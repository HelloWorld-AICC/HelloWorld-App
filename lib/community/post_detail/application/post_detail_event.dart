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
