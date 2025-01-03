import 'dart:io';

import 'package:hello_world_mvp/community/common/domain/creat_post.dart';

class CreatePostDto {
  final String title;
  final String body;
  final List<File> medias;

  CreatePostDto({
    required this.title,
    required this.body,
    required this.medias,
  });

  CreatePost toDomain() {
    return CreatePost(title: title, body: body, medias: medias);
  }

  factory CreatePostDto.fromDomain(CreatePost post) {
    return CreatePostDto(
      title: post.title,
      body: post.body,
      medias: post.medias,
    );
  }

  factory CreatePostDto.fromJson(Map<String, dynamic> json) {
    return CreatePostDto(
      title: json['title'],
      body: json['body'],
      medias: json['medias'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'medias': medias,
    };
  }
}
