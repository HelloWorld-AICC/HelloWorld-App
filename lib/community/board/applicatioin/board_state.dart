// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'board_bloc.dart';

class BoardState extends Equatable {
  final List<Post>? postList;
  final CommunityFailure? failure;
  final bool isLoading;
  final PostCategory selectedBoard;
  final int page;
  final bool ended;

  const BoardState({
    required this.postList,
    required this.failure,
    required this.isLoading,
    required this.selectedBoard,
    required this.page,
    required this.ended,
  });

  factory BoardState.initial() => const BoardState(
        postList: null,
        failure: null,
        isLoading: false,
        selectedBoard: PostCategory.suffering,
        page: 0,
        ended: false,
      );

  @override
  List<Object?> get props =>
      [postList, failure, isLoading, selectedBoard, page, ended];

  BoardState copyWith({
    List<Post>? postList,
    CommunityFailure? failure,
    bool? isLoading,
    PostCategory? selectedBoard,
    int? page,
    bool? ended,
  }) {
    return BoardState(
      postList: postList ?? this.postList,
      failure: failure ?? this.failure,
      isLoading: isLoading ?? this.isLoading,
      selectedBoard: selectedBoard ?? this.selectedBoard,
      page: page ?? this.page,
      ended: ended ?? this.ended,
    );
  }
}
