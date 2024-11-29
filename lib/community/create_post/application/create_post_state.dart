// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_post_bloc.dart';

class CreatePostState extends Equatable {
  final String? title;
  final String? body;
  final List<XFile> media;
  final bool isLoading;
  final bool isSuccess;
  final Failure? failure;

  const CreatePostState({
    required this.title,
    required this.body,
    required this.media,
    required this.isLoading,
    required this.isSuccess,
    required this.failure,
  });

  factory CreatePostState.initial() => const CreatePostState(
        title: null,
        body: null,
        media: [],
        isLoading: false,
        isSuccess: false,
        failure: null,
      );

  @override
  List<Object?> get props => [title, body];

  CreatePostState copyWith({
    String? title,
    String? body,
    List<XFile>? media,
    bool? isLoading,
    bool? isSuccess,
    Failure? failure,
  }) {
    return CreatePostState(
      title: title ?? this.title,
      body: body ?? this.body,
      media: media ?? this.media,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      failure: failure ?? this.failure,
    );
  }
}
