// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'post_detail_bloc.dart';

class PostDetailState extends Equatable {
  final String? title;
  final String? body;
  final List<XFile> medias;
  final DateTime createdAt;
  final List<Comment> comments;
  final bool isLoading;
  final bool isSuccess;
  final Failure? failure;

  const PostDetailState({
    required this.title,
    required this.body,
    required this.medias,
    required this.createdAt,
    required this.comments,
    required this.isLoading,
    required this.isSuccess,
    required this.failure,
  });

  factory PostDetailState.initial() => PostDetailState(
        title: null,
        body: null,
        medias: [],
        createdAt: DateTime.now(),
        comments: [],
        isLoading: false,
        isSuccess: false,
        failure: null,
      );

  @override
  List<Object?> get props =>
      [title, body, medias, comments, isLoading, isSuccess, failure];

  PostDetailState copyWith({
    String? title,
    String? body,
    List<XFile>? medias,
    DateTime? createdAt,
    List<Comment>? comments,
    bool? isLoading,
    bool? isSuccess,
    Failure? failure,
  }) {
    return PostDetailState(
      title: title ?? this.title,
      body: body ?? this.body,
      medias: medias ?? this.medias,
      createdAt: createdAt ?? this.createdAt,
      comments: comments ?? this.comments,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      failure: failure ?? this.failure,
    );
  }
}
