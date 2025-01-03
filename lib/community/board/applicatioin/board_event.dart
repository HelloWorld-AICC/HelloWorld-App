part of 'board_bloc.dart';

sealed class BoardEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class GetPosts extends BoardEvent {
  GetPosts();

  @override
  List<Object> get props => [];
}

final class SelectBoard extends BoardEvent {
  final PostCategory category;
  SelectBoard({required this.category});

  @override
  List<Object> get props => [];
}
