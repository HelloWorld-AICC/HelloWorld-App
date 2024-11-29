import 'dart:io';

import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final String title;
  final String body;
  final List<File> medias;

  const Post({required this.title, required this.body, required this.medias});

  @override
  List<Object?> get props => [title, body, medias];
}
