part of 'create_post_bloc.dart';

sealed class CreatePostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class TitleChanged extends CreatePostEvent {
  final String title;

  TitleChanged({required this.title});

  @override
  List<Object> get props => [title];
}

final class BodyChanged extends CreatePostEvent {
  final String body;

  BodyChanged({required this.body});

  @override
  List<Object> get props => [body];
}

final class MediaChanged extends CreatePostEvent {
  final List<XFile> medias;

  MediaChanged({required this.medias});

  @override
  List<Object> get props => [medias];
}

//select media
final class SelectMedia extends CreatePostEvent {
  SelectMedia();

  @override
  List<Object> get props => [];
}

final class SubmitPost extends CreatePostEvent {
  SubmitPost();

  @override
  List<Object> get props => [];
}
