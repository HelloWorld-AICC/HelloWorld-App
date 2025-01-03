// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'terms_of_service_bloc.dart';

class TermsOfServiceSate extends Equatable {
  final PostList? postList;
  final CommunityFailure? failure;
  final bool isLoading;
  final PostCategory selectedBoard;
  final int page;

  const TermsOfServiceSate({
    required this.postList,
    required this.failure,
    required this.isLoading,
    required this.selectedBoard,
    required this.page,
  });

  factory TermsOfServiceSate.initial() => const TermsOfServiceSate(
        postList: null,
        failure: null,
        isLoading: false,
        selectedBoard: PostCategory.suffering,
        page: 0,
      );

  @override
  List<Object?> get props => [postList, failure, isLoading, selectedBoard];

  TermsOfServiceSate copyWith({
    PostList? postList,
    CommunityFailure? failure,
    bool? isLoading,
    PostCategory? selectedBoard,
    int? page,
  }) {
    return TermsOfServiceSate(
        postList: postList ?? this.postList,
        failure: failure ?? this.failure,
        isLoading: isLoading ?? this.isLoading,
        selectedBoard: selectedBoard ?? this.selectedBoard,
        page: page ?? this.page);
  }
}
