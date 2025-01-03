// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'board_bloc.dart';

class BoardState extends Equatable {
  final PostList? postList;
  final CommunityFailure? failure;
  final bool isLoading;
  final PostCategory selectedBoard;
  final int page;

  const BoardState({
    required this.postList,
    required this.failure,
    required this.isLoading,
    required this.selectedBoard,
    required this.page,
  });

  factory BoardState.initial() => const BoardState(
        postList: null,
        failure: null,
        isLoading: false,
        selectedBoard: PostCategory.suffering,
        page: 0,
      );

  @override
  List<Object?> get props => [postList, failure, isLoading, selectedBoard];

  BoardState copyWith({
    PostList? postList,
    CommunityFailure? failure,
    bool? isLoading,
    PostCategory? selectedBoard,
    int? page,
  }) {
    return BoardState(
        postList: postList ?? this.postList,
        failure: failure ?? this.failure,
        isLoading: isLoading ?? this.isLoading,
        selectedBoard: selectedBoard ?? this.selectedBoard,
        page: page ?? this.page);
  }
}
